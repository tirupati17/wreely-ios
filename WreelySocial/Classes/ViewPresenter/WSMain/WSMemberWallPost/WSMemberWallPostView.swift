//
//  WSMemberWallPostView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import YPImagePicker
import Lightbox
import Cloudinary

struct WSMemberWallPostViewItem {
    var statusText : String? = ""
    var statusDate : Date? = Date()
    var statusImageUrl : String? = ""
    var isAttachment : Bool? = false
}

let memberWallPostTextViewCellId = "memberWallPostTextViewCell"
let memberWallPostAttachmentCellId = "memberWallPostAttachmentCell"

class WSMemberWallPostView : WSViewController {
    var tableView : UITableView = UITableView()
    var memberWallPostPresenterProtocol : WSMemberWallPostPresenterProtocol!
    
    
    var memberWallPostViewItem = WSMemberWallPostViewItem()
    var tempAttachedImage : UIImage? = nil
    var uploadRequest : CLDUploadRequest? = nil
    var cloudinary : CLDCloudinary = {
        let config = CLDConfiguration(cloudName: "celerstudio", secure: true)
        let cloudinary = CLDCloudinary(configuration: config)
        return cloudinary
    }()
    
    var rightButton : UIBarButtonItem = {
        let rightButton = UIBarButtonItem.init(title: "Share", style: .plain, target: self, action: #selector(savePost))
        rightButton.tintColor = UIColor.white
        rightButton.isEnabled = false
        return rightButton
    }()
    
    var leftButton : UIBarButtonItem = {
        let rightButton = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(cancelPost))
        rightButton.tintColor = UIColor.white
        return rightButton
    }()

    
    var keyboardHeight : CGFloat = isIPhoneX ? 333 : 278 {
        didSet {

        }
    }
    override func loadView() {
        super.loadView()
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton

        self.title = "Create post"
        self.configureDependencies()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let memberWallPostPresenter = WSMemberWallPostPresenter()
        memberWallPostPresenter.memberWallPostViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.memberWallPostPresenterProtocol = memberWallPostPresenter //VIEW -> PRESENTER  CONNECTION
        
        view.addSubview(tableView)
        view.addConstraintsWithFormat("H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat("V:|[v0]|", views: tableView)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(WSMemberWallPostTextViewCell.self, forCellReuseIdentifier: memberWallPostTextViewCellId)
        self.tableView.register(WSMemberWallPostAttachmentCell.self, forCellReuseIdentifier: memberWallPostAttachmentCellId)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeight = keyboardSize.height + (isIPhoneX ? 35 : 15)
        }
    }

    @IBAction func cancelPost() {
        if (self.uploadRequest != nil) {
            self.uploadRequest?.suspend()
        }
        self.dismiss(animated: true) {}
    }
    
    @IBAction func savePost() {
        if (self.memberWallPostViewItem.statusText?.isEmpty)! == true && (self.memberWallPostViewItem.statusImageUrl?.isEmpty)! == true {
            return
        }
        self.startViewAnimation()
        self.memberWallPostPresenterProtocol.submitPost(memberWallPostViewItem: self.memberWallPostViewItem)
    }
    
    func showPreviewImage() {
        if !((self.memberWallPostViewItem.statusImageUrl?.isEmpty)!)  {
            let images = [
                LightboxImage(imageURL: URL(string: self.memberWallPostViewItem.statusImageUrl!)!, text : "")
            ]
            let controller = LightboxController(images: images)
            
            controller.dynamicBackground = true
            present(controller, animated: true, completion: nil)
        }
    }
    
    func uploadFile(_ data : Data) {
        self.navigationController?.backgroundColor = UIColor.white
        self.navigationController?.primaryColor = UIColor.red
        self.navigationController?.isShowingProgressBar = true
        
        self.rightButton.isEnabled = false
        self.uploadRequest = cloudinary.createUploader().upload(data: data, uploadPreset: "g6wn2bmb", progress: { (pro) in
            self.navigationController?.setProgress(Float(pro.fractionCompleted), animated: true)
        }) { (response, error) in
            print(response ?? "no response")
            print(error ?? "no error")
            if ((error) != nil) {
                self.showToastMessage((error?.localizedDescription)!)
            } else {
                self.memberWallPostViewItem.statusImageUrl = response?.secureUrl
                self.memberWallPostViewItem.isAttachment = true
            }
            self.hideProgressBar()
            self.rightButton.isEnabled = true
            self.tableView.reloadData()
        }
    }
    
    func hideProgressBar() {
        self.navigationController?.finishProgress()
        self.navigationController?.isShowingProgressBar = false
    }
}

extension WSMemberWallPostView : WSMemberWallPostViewProtocol {
    func didSuccessfulResponse<T>(_ response: T) {
        _ = response as JSON
        self.stopViewAnimation()
        self.dismissSelf()
    }
    
    func didFailedResponse<T>(_ error: T) {
        let error = error as! Error
        
        self.stopViewAnimation()
        self.showToastMessage(error.getDetailErrorInfo()!)
    }
    
    func presentController<T>(_ vc: T) {
        self.present(vc as! UIViewController, animated: true) {}
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
}

extension WSMemberWallPostView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                print("Height: \(keyboardHeight)")
                return CGFloat(Int(tableView.height) - Int(Int(self.keyboardHeight) + 60 + 49))
            default:
                return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            case 0:
                break
            default:
                var config = YPImagePickerConfiguration()
                config.library.mediaType = .photo
                config.library.onlySquare  = false
                config.onlySquareImagesFromCamera = false
                config.targetImageSize = .original
                config.usesFrontCamera = true
                config.showsFilters = true
                config.shouldSaveNewPicturesToAlbum = true
                config.albumName = "Wreely"
                config.screens = [.library, .photo]
                config.startOnScreen = .library
                config.video.recordingTimeLimit = 10
                config.video.libraryTimeLimit = 20
                config.wordings.libraryTitle = "Gallery"
                config.hidesStatusBar = false
                config.library.maxNumberOfItems = 1
                config.library.minNumberOfItems = 1
                config.library.numberOfItemsInRow = 3
                config.library.spacingBetweenItems = 2
                config.isScrollToChangeModesEnabled = false
                
                let picker = YPImagePicker(configuration: config)
                picker.didFinishPicking { [unowned picker] items, _ in
                    if let photo = items.singlePhoto {
                        print(photo.fromCamera) // Image source (camera or library)
                        print(photo.image) // Final image selected by the user
                        print(photo.originalImage) // original image selected by the user, unfiltered
                        if photo.modifiedImage != nil {
                            self.tempAttachedImage = photo.modifiedImage!
                        } else {
                            self.tempAttachedImage = photo.originalImage
                        }
                        //self.uploadFile(UIImageJPEGRepresentation(self.tempAttachedImage!, 0.7)!)
                        self.uploadFile(self.tempAttachedImage?.jpegData(compressionQuality: 0.7) ?? Data.init())

                        self.tableView.reloadData()
                    }
                    picker.dismiss(animated: true, completion: nil)
                }
                present(picker, animated: true, completion: {
                    picker.navigationController?.isNavigationBarHidden = false
                })
                break
        }
    }
}

extension WSMemberWallPostView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
            case 0:
                let cell:WSMemberWallPostTextViewCell = tableView.dequeueReusableCell(withIdentifier: memberWallPostTextViewCellId, for: indexPath) as! WSMemberWallPostTextViewCell
                cell.textView.delegate = self
                cell.textView.becomeFirstResponder()
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                cell.controller = self
                return cell
            default:
                let cell:WSMemberWallPostAttachmentCell = tableView.dequeueReusableCell(withIdentifier: memberWallPostAttachmentCellId, for: indexPath) as! WSMemberWallPostAttachmentCell
                cell.thumbImageView.image = self.tempAttachedImage == nil ? UIImage.init(named: "placeholder-image") : self.tempAttachedImage
                if (self.memberWallPostViewItem.isAttachment == true) {
                    cell.titleLabel.text = "Replace Photo"
                } else {
                    cell.titleLabel.text = "Attach Photo"
                }
                cell.controller = self
                cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
                cell.accessoryType = .disclosureIndicator
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}

extension WSMemberWallPostView : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.memberWallPostViewItem.statusText = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        let count = (self.memberWallPostViewItem.statusText?.count)!
        rightButton.isEnabled = count == 0 && self.memberWallPostViewItem.isAttachment == false ? false : !((self.navigationController?.isShowingProgressBar)!)
        return count <= 60000
    }
}


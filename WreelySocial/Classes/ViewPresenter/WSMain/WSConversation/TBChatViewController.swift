//
//  TBChatViewController.swift
//
//  Created by Tirupati Balan on 19/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GrowingTextView

class TBChatViewController : WSViewController, SideMenuItemContent {
    var collectionView : UICollectionView!
    var selectedUser : WSMember! //For one to one chat
    var selectedVendor : WSVendor! //For group chat
    private let cellId = "cellId"
    var messageArray = [WSFIRMessages]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var inputToolbar: UIView!
    var growingTextView : GrowingTextView!
    var firebaseDatabaseRef : FirebaseDatabaseRef = .oneToOneChat

    override func loadView() {
        super.loadView()
        
        self.collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: self.view.height - kToolBarHeight)), collectionViewLayout: UICollectionViewFlowLayout.init())
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(self.collectionView)

        switch self.firebaseDatabaseRef {
            case .oneToOneChat:
                self.navigationItem.title = selectedUser.name
                break
            case .groupChat:
                self.navigationItem.title = "\(selectedVendor.name!)"
                break
        default:
            break
        }
        let backgroundImage = UIImage(named: "bg_app_background")
        let imageView = UIImageView(image: backgroundImage)
        self.collectionView.backgroundView = imageView
        self.configureBottomTextView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startViewAnimation()
        self.loadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @objc func showMenu() {
        showSideMenu()
    }
    
    func getRoomId() -> String {
        var roomId = ""
        switch self.firebaseDatabaseRef {
            case .oneToOneChat:
                //Unique room id via asc order of two users firebase id so it will be unique in any platform
                let string = [WSFirebaseSession.activeSession().currentUser().firebaseId!, self.selectedUser.memberFirKey].sorted { $0!.localizedCaseInsensitiveCompare($1!) == ComparisonResult.orderedAscending }
                roomId = string.map({"\($0 ?? "")"}).joined(separator: "-")
                break
            case .groupChat:
                roomId = "\(selectedVendor.id!)"
                break
            default:
                break
        }
        return roomId
    }
    
    func loadData() {
        WSFirebaseRequest().firebaseObserveMessages(self.firebaseDatabaseRef, withChatRoomId: self.getRoomId()) { (messages) in
            self.stopViewAnimation()
            let listArray = messages as! [WSFIRMessages]
            if (listArray.elementsEqual(self.messageArray, by: { $0.memberId == $1.memberId })) { //WTF: firebse observe calling twice
                //same order and data
            } else {
                self.messageArray = listArray
                self.scrollToBottom()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            if (self.messageArray.count > 0) {
                self.collectionView.scrollToItem(at: IndexPath.init(row: self.messageArray.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    @objc func sendMessage() {
        if (self.growingTextView.text?.isEmpty)! { return }
        
        let message = WSFIRMessages.init()
        message.message = self.growingTextView.text
        message.senderFirebaseId = WSFirebaseSession.activeSession().currentUser().firebaseId
        message.memberId = WSSession.activeSession().currentUser().id
        message.profilePicUrl = WSSession.activeSession().currentUser().profilePicUrl
        message.receiverFirebaseId = self.firebaseDatabaseRef == .oneToOneChat ? selectedUser.memberFirKey : ""
        message.userName = WSSession.activeSession().currentUser().name
        message.incoming = false
        self.growingTextView.text = ""
        WSFirebaseRequest().firebaseSendMessages(self.firebaseDatabaseRef, withChatRoomId: self.getRoomId(), data : message)
    }
}

extension TBChatViewController {
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : CGFloat = (self.view.height - (endFrame.origin.y - kToolBarHeight))
            if (keyboardHeight > 0) {
                scrollToBottom()
                UIView.animate(withDuration: notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey]! as! TimeInterval, animations: { () -> Void in
                    self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: (self.view.height - keyboardHeight)))
                    self.inputToolbar.frame = CGRect(origin: CGPoint(x: 0, y: endFrame.origin.y - kToolBarHeight), size: self.inputToolbar.frame.size)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey]! as! TimeInterval, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
                    let collectionViewHeight = self.view.height - kToolBarHeight
                    
                    self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: collectionViewHeight))
                    self.inputToolbar.frame = CGRect(origin: CGPoint(x: 0, y: collectionViewHeight), size: self.inputToolbar.frame.size)
                }, completion: nil)
            }
        }
    }
    
    @objc private func tapGestureHandler() {
        self.growingTextView.resignFirstResponder()
    }

    func configureBottomTextView() {
        inputToolbar = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: self.collectionView.height), size: CGSize(width: self.view.width, height: kToolBarHeight)))
        inputToolbar.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        self.view.addSubview(inputToolbar)
        
        growingTextView = GrowingTextView.init(frame: CGRect(origin: CGPoint(x: 0, y: 1), size: CGSize(width: self.view.width - 60 , height: kToolBarHeight)))
        growingTextView.backgroundColor = UIColor.white
        growingTextView.maxLength = 1024
        growingTextView.trimWhiteSpaceWhenEndEditing = false
        growingTextView.placeholder = "Enter text"
        growingTextView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        growingTextView.minHeight = kToolBarHeight
        growingTextView.maxHeight = kToolBarHeight
        growingTextView.delegate = self
        growingTextView.font = UIFont.systemFont(ofSize: 14)
        inputToolbar.addSubview(growingTextView)
        growingTextView.becomeFirstResponder()
        
        let button = UIButton.init(frame: CGRect(origin: CGPoint(x: growingTextView.width, y: 1), size: CGSize(width: 60 , height: kToolBarHeight - 1)))
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.getAppBoldFont(size: 14)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        inputToolbar.addSubview(button)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
}

extension TBChatViewController : GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension TBChatViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = self.messageArray[indexPath.item].message {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 14)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 45)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let message = self.messageArray[safe : indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! ChatLogMessageCell
            cell.messageTextView.text = message.message
            
            cell.profileImageView.image = UIImage(named: "user-placeholder")
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: message.message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 14)], context: nil)
            
            if  (message.isCurrentUser() == false) {
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 20, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: 17, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
                
                cell.profileImageView.isHidden = false
                
                cell.profileImageView.kf.setImage(with: URL.init(string: message.profilePicUrl!), placeholder: Image.init(named: "user-placeholder"))
                
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                cell.nameLabel.textAlignment = .left
                cell.nameLabel.text = "\( self.firebaseDatabaseRef == .oneToOneChat ? "" : (message.userName ?? "")) \(Date.init(timeIntervalSince1970: Double(message.timestamp!/1000)).to24HourTimeString)"
            } else {
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 20, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                let xVal = (view.frame.width - estimatedFrame.width)
                
                cell.textBubbleView.frame = CGRect(x: xVal - 16 - 8 - 16 - 10, y: 17, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                
                cell.profileImageView.isHidden = true
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage
                cell.bubbleImageView.tintColor = UIColor.themeColor()
                cell.messageTextView.textColor = UIColor.white
                cell.nameLabel.textAlignment = .right
                cell.nameLabel.text = Date.init(timeIntervalSince1970: Double(message.timestamp!/1000)).to24HourTimeString
            }
            return cell
        } else { return UICollectionViewCell.init()}
    }
    
}

//
//  WSMemberWallCommentView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import GrowingTextView

let memberWallCommentCell = "memberWallCommentCell"

class WSMemberWallCommentView : WSViewController {
    var tableView : UITableView = UITableView()
    var memberWallCommentPresenterProtocol : WSMemberWallCommentPresenterProtocol!
    private var inputToolbar: UIView!
    var growingTextView : GrowingTextView!
    var memberWall : WSMemberWall! {
        didSet {
        }
    }
    
    var viewHeight : CGFloat = {
        return CGFloat(UIScreen.main.bounds.height - kTabBarHeight)
    }()
    
    var comments = [WSMemberWallComments]() {
        didSet {
            if (comments.count == 0) {
                //add tableview placeholder
            }
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "Comments"
        self.configureDependencies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startViewAnimation()
        self.memberWallCommentPresenterProtocol.didFetchComment(forPost: memberWall!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let memberWallCommentPresenter = WSMemberWallCommentPresenter()
        memberWallCommentPresenter.memberWallCommentViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.memberWallCommentPresenterProtocol = memberWallCommentPresenter //VIEW -> PRESENTER  CONNECTION
        
        self.tableView = UITableView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: self.view.height - kToolBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(WSMemberWallCommentCell.self, forCellReuseIdentifier: memberWallCommentCell)
        self.configureBottomTextView()
    }
    
    @objc func showUserProfile(_ id : Int) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func sendComment() {
        if !(self.growingTextView.text?.isEmpty)! {
            let data = ["post_id":"\((memberWall?.id)!))", "comment_by_member_id":"\(WSSession.activeSession().currentUser().id!)", "comment":"\(self.growingTextView.text!)"]
            self.memberWallCommentPresenterProtocol.didSendComment(data: data)
            self.growingTextView.text = ""
        }
    }
    
    func moreAction(_ comment : WSMemberWallComments) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if (comment.memberId == WSSession.activeSession().currentUser().id) {
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                print("User click delete button")
                self.memberWallCommentPresenterProtocol.didDeleteComment(comment: comment)
                let commentList = self.comments.filter({ (commentObj) -> Bool in
                    if (commentObj.id == comment.id) {
                        return false
                    }
                    return true
                })
                self.comments = commentList
            }))
        }
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

}

extension WSMemberWallCommentView : UIActionSheetDelegate {
    
}

extension WSMemberWallCommentView {
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : CGFloat = (self.view.height - (endFrame.origin.y - kToolBarHeight))
            if (keyboardHeight > 0) {
                UIView.animate(withDuration: notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey]! as! TimeInterval, animations: { () -> Void in
                    self.tableView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: (self.view.height - keyboardHeight)))
                    self.inputToolbar.frame = CGRect(origin: CGPoint(x: 0, y: endFrame.origin.y - kToolBarHeight), size: self.inputToolbar.frame.size)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
                    let tableViewHeight = self.view.height - kToolBarHeight
                    
                    self.tableView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: tableViewHeight))
                    self.inputToolbar.frame = CGRect(origin: CGPoint(x: 0, y: tableViewHeight), size: self.inputToolbar.frame.size)
                }, completion: nil)
            }
        }
    }
    
    @objc private func tapGestureHandler() {
        self.growingTextView.resignFirstResponder()
    }
    
    func configureBottomTextView() {
        inputToolbar = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: self.tableView.height), size: CGSize(width: self.view.width, height: kToolBarHeight)))
        inputToolbar.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        self.view.addSubview(inputToolbar)
        
        growingTextView = GrowingTextView.init(frame: CGRect(origin: CGPoint(x: 0, y: 1), size: CGSize(width: self.view.width - 60 , height: kToolBarHeight - 1)))
        growingTextView.backgroundColor = UIColor.white
        growingTextView.maxLength = 1024
        growingTextView.trimWhiteSpaceWhenEndEditing = false
        growingTextView.placeholder = "Enter comment"
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
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        inputToolbar.addSubview(button)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
}

extension WSMemberWallCommentView : GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension WSMemberWallCommentView : WSMemberWallCommentViewProtocol {
    
    func updateCommentList(_ response: [WSMemberWallComments]) {
        self.comments = response
        if (comments.count > 0) {
            DispatchQueue.main.async {
                self.tableView.scrollToRow(at: IndexPath.init(row: self.comments.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
                self.title = "Comments (\(self.comments.count))"
            }
        }
        self.stopViewAnimation()
    }

    func didSuccessfulResponse<T>(_ response: T) {
        print(response)
        self.stopViewAnimation()
        self.memberWallCommentPresenterProtocol.didFetchComment(forPost: memberWall!)
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

extension WSMemberWallCommentView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rect = NSString(string: comments[indexPath.item].comment!).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 14)], context: nil)
        
        let textViewHeight = rect.height
        let knownHeight: CGFloat = 10 + 40 + 10 + textViewHeight + 24
        return knownHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSMemberWallCommentView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSMemberWallCommentCell = tableView.dequeueReusableCell(withIdentifier: memberWallCommentCell, for: indexPath) as! WSMemberWallCommentCell
        
        cell.controller = self
        cell.accessoryType = .none
        if let commentBy = self.comments[safe : indexPath.row] {
            cell.comment = commentBy
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}

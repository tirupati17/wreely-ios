//
//  WSMemberWallView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Lightbox

let memberWallCellId = "memberWallCell"
let memberWallMediaCellId = "memberWallMediaCell"
let memberWallTextCellId = "memberWallTextCell"
let memberWallTextMediaCellId = "memberWallTextMediaCell"

class WSMemberWallView : WSViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var topTextField : UITextField!

    var memberWallPresenterProtocol : WSMemberWallPresenterProtocol!
    var memberWalls = [WSMemberWall]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDependencies()
        
        self.startViewAnimation()
    }
    
    func configureDependencies() {
        let memberWallPresenter = WSMemberWallPresenter()
        memberWallPresenter.memberWallViewProtocol = self
        self.memberWallPresenterProtocol = memberWallPresenter
        
        navigationItem.title = "Members Wall"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(WSMemberWallTextMediaCell.self, forCellWithReuseIdentifier: memberWallTextMediaCellId)
        collectionView?.register(WSMemberWallTextCell.self, forCellWithReuseIdentifier: memberWallTextCellId)
        collectionView?.register(WSMemberWallMediaCell.self, forCellWithReuseIdentifier: memberWallMediaCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memberWallPresenterProtocol.didFetchWallFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.memberWallPresenterProtocol.didFetchWallFeeds()
    }
    
    func showPreview(_ post : WSMemberWall) {
        let images = [
            LightboxImage(imageURL: URL(string: post.statusImage!)!, text : post.statusText!)
        ]
        let controller = LightboxController(images: images)
        
        controller.dynamicBackground = true
        present(controller, animated: true, completion: nil)
    }
    
    func initiateLike(_ post : WSMemberWall) {
        self.memberWallPresenterProtocol.didUpdateLike(forPost: post)
        self.memberWalls = memberWalls.map { (wallPost) -> WSMemberWall in
            var wallPostObject = wallPost
            if (wallPostObject.id == post.id) {
                wallPostObject.isLikedByMe = wallPostObject.isLikedByMe! ? false : true
                wallPostObject.numberOfLikes = wallPostObject.numberOfLikes! + (wallPostObject.isLikedByMe! ? 1 : -1)
            }
            return wallPostObject
        }
        collectionView.reloadData()
    }
    
    func initiateComment(_ post : WSMemberWall) {
        //show comment list with become first responder
    }
    
    func showLikeList(_ post : WSMemberWall) {
        
    }

    func showCommentList(_ post : WSMemberWall) {
        let vc = WSMemberWallLikeCommentPageController()
        vc.isCommentMode = true
        vc.memberWall = post
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLikeCommentList(_ post : WSMemberWall) {
        let vc = WSMemberWallLikeCommentPageController()
        vc.memberWall = post
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showUserProfile(_ id : Int) {
        
    }

    func showMessageList(_ post : WSMemberWall) {
        return
        let vc = TBChatViewController()
        vc.firebaseDatabaseRef = .oneToOneChat
        vc.selectedUser = WSMember.init(id: post.memberId!, name: post.name!, profilePicUrl: post.memberProfileImage!) //need firebase key of users
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moreAction(_ post : WSMemberWall) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Mute notifications", style: .default , handler:{ (UIAlertAction)in
            print("User click delete button")
        }))
        if (post.memberId == WSSession.activeSession().currentUser().id) {
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                print("User click delete button")
                self.memberWallPresenterProtocol.didDeleteWallPost(wallPost: post)
                let walls = self.memberWalls.filter({ (wallPost) -> Bool in
                    if (wallPost.id == post.id) {
                        return false
                    }
                    return true
                })
                self.memberWalls = walls
                self.collectionView.reloadData()
            }))
        } else {
            alert.addAction(UIAlertAction(title: "Report", style: .destructive , handler:{ (UIAlertAction)in
                print("User click Report button")
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

extension WSMemberWallView : UIActionSheetDelegate {

}

extension WSMemberWallView : WSMemberWallViewProtocol {
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        
    }
    
    func updateWallPost(_ wallPosts: [WSMemberWall]) {
        self.memberWalls = wallPosts
        self.collectionView.reloadData()
        self.stopViewAnimation()
    }
    
    func updateLikeStatus() {
        
    }
    
    func didFailedResponse<T>(_ error: T) {
        self.collectionView.reloadData()
        self.stopViewAnimation()
    }
}

extension WSMemberWallView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberWalls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell : WSMemberWallCell
        if ((memberWalls[indexPath.item].statusImages.count) > 0 && (memberWalls[indexPath.item].statusText?.isEmpty)! == false)  {
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: memberWallTextMediaCellId, for: indexPath) as! WSMemberWallTextMediaCell
        } else if ((memberWalls[indexPath.item].statusImages.count) > 0) {
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: memberWallMediaCellId, for: indexPath) as! WSMemberWallMediaCell
        } else {
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: memberWallTextCellId, for: indexPath) as! WSMemberWallTextCell
        }
        collectionViewCell.post = memberWalls[indexPath.item]
        collectionViewCell.controller = self
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rect = NSString(string: memberWalls[indexPath.item].statusText!).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 14)], context: nil)
        
        var imageViewHeight = CGFloat(0)
        var textViewHeight = rect.height
        
        if ((memberWalls[indexPath.item].statusImages.count) > 0 && (memberWalls[indexPath.item].statusText?.isEmpty)! == false)  {
            imageViewHeight = CGFloat(200) + CGFloat(24)
        } else if ((memberWalls[indexPath.item].statusImages.count) > 0) {
            imageViewHeight = CGFloat(200)
            textViewHeight = CGFloat(0)
        } else {
            imageViewHeight = CGFloat(0) + CGFloat(24)
        }
        
        var knownHeight: CGFloat = (8 + 44 + 4 + 4)
        knownHeight = knownHeight + imageViewHeight
        knownHeight = knownHeight + (8 + 24 + 8 + 44)
        return CGSize(width: view.frame.width, height: textViewHeight + knownHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension WSMemberWallView : UICollectionViewDataSource {
    
}

extension WSMemberWallView : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let postVc = WSMemberWallPostView()
        let nv = UINavigationController.init(rootViewController: postVc)
        self.presentWithAnimated(nv)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

//
//  WSMemberWallCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material
import DateToolsSwift

enum WSMemberWallCellUIControlTag : Int {
    case unknownType
}

class WSMemberWallCell : WSCollectionViewCell {
    var controller: WSMemberWallView?
    var isUpdatedC: Bool? = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(moreButton)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(messageButton)
        messageButton.isHidden = true
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(previewAction)))
        likesCommentsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showLikeCommentList)))
        likeButton.addTarget(self, action: #selector(initiateLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(showCommentList), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        profileImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showUserProfile)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func showUserProfile() {
        controller?.showUserProfile(0)
    }
    
    @objc func previewAction() {
        controller?.showPreview(post!)
    }
    
    @objc func initiateLike() {
        controller?.initiateLike(post!)
    }
    
    @objc func showCommentList() {
        controller?.showCommentList(post!)
    }
    
    @objc func showLikeCommentList() {
        controller?.showLikeCommentList(post!)
    }
    
    @objc func moreAction() {
        controller?.moreAction(post!)
    }
    
    @objc func showMessageList() {
        controller?.showMessageList(post!)
    }
    
    var post: WSMemberWall? {
        didSet {
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.getAppBoldFont(size: 14)])
                
                if let date = post?.date {
                    attributedText.append(NSAttributedString(string: "\n\(date.toServerDate.timeAgoSinceNow) •  ", attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 12), NSAttributedString.Key.foregroundColor:
                        UIColor.rgb(155, green: 161, blue: 161)]))
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    
                    attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                    
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: "earth-globe")
                    attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                    attributedText.append(NSAttributedString(attachment: attachment))
                }
                nameLabel.attributedText = attributedText
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            profileImageView.setImage(string: "user-placeholder")
            if let profileImagename = post?.memberProfileImage {
                profileImageView.kf.setImage(with: URL.init(string: profileImagename), placeholder: Image.init(named: "user-placeholder"))
            }
            
            if let numLikes = post?.numberOfLikes, let numComments = post?.numberOfCommment {
                likesCommentsLabel.text = "\(numLikes) Likes \(numComments) Comments"
            }
            
            statusImageView.isHidden = true
            if (post?.statusImage?.isEmpty == false) {
                statusImageView.kf.setImage(with: URL.init(string: (post?.statusImage)!), placeholder: Image.init(named: "placeholder-image"))
                statusImageView.isHidden = false
            }
            
            likeButton.setTitle((post?.isLikedByMe)! ? "Liked" : "Like", for: UIControl.State())
            likeButton.setTitleColor((post?.isLikedByMe)! ? UIColor.themeColor() : UIColor.lightGray , for: UIControl.State())
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.borderColor = UIColor.init(white: 0.96, alpha: 1).cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.getAppRegularFont(size: 14)
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .all
        textView.isEditable = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = UIFont.getAppRegularFont(size: 14)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppRegularFont(size: 14)
        label.textAlignment = .left
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppRegularFont(size: 14)
        label.textAlignment = .right
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    let moreButton = WSMemberWallCell.buttonForTitle("", imageName: "more")
    let likeButton = WSMemberWallCell.buttonForTitle("Like", imageName: "thumbs-up")
    let commentButton: UIButton = WSMemberWallCell.buttonForTitle("Comment", imageName: "comment-white-oval-bubble")
    let messageButton: UIButton = WSMemberWallCell.buttonForTitle("Message", imageName: "share")
    
    static func buttonForTitle(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(UIColor.lightGray, for: UIControl.State())
        
        button.setImage(UIImage(named: imageName), for: UIControl.State())
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        button.titleLabel?.font = UIFont.getAppMediumFont(size: 14)
        return button
    }
}

class WSMemberWallTextCell : WSMemberWallCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedC == false) {
            isUpdatedC = true
            
            addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1][v2(60)]|", views: profileImageView, nameLabel, moreButton)
            addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: likesCommentsLabel)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)

            addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, messageButton)
            addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
            addConstraintsWithFormat("V:|[v0(50)]", views: moreButton)
            
            addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(24)]-8-[v3(0.4)][v4(44)]|", views: profileImageView, statusTextView, likesCommentsLabel, dividerLineView, likeButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: messageButton)
        }
    }
}

class WSMemberWallMediaCell : WSMemberWallCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedC == false) {
            isUpdatedC = true
            
            addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1][v2(60)]|", views: profileImageView, nameLabel, moreButton)
            addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: likesCommentsLabel)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
            
            addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, messageButton)
            addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
            addConstraintsWithFormat("V:|[v0(50)]", views: moreButton)

            addConstraintsWithFormat("V:|-8-[v0(44)]-8-[v1(200)]-8-[v2(24)]-8-[v3(0.4)][v4(44)]|", views: profileImageView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: messageButton)
        }
    }
}

class WSMemberWallTextMediaCell : WSMemberWallCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedC == false) {
            isUpdatedC = true
            
            addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1][v2(60)]|", views: profileImageView, nameLabel, moreButton)
            addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
            addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: likesCommentsLabel)
            addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
            
            addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, messageButton)
            addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
            addConstraintsWithFormat("V:|[v0(50)]", views: moreButton)

            addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
            addConstraintsWithFormat("V:[v0(44)]|", views: messageButton)
        }
    }
}

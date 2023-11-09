//
//  WSMemberWallCommentCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallCommentCell : WSTableViewCell {
    var controller: WSMemberWallCommentView?
    var comment: WSMemberWallComments? {
        didSet {
            self.thumbImageView.kf.setImage(with: URL.init(string: (comment?.memberProfileImage!)!), placeholder: Image.init(named: "user-placeholder"))
            self.commentTextView.text = comment?.comment
            
            self.moreButton.isHidden = comment?.memberId == WSSession.activeSession().currentUser().id ? false : true
            if let name = comment?.memberName {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.getAppBoldFont(size: 14)])
                
                if let date = comment?.date {
                    attributedText.append(NSAttributedString(string: "\n\(date.toServerDate.timeAgoSinceNow)", attributes: [NSAttributedString.Key.font: UIFont.getAppRegularFont(size: 12), NSAttributedString.Key.foregroundColor:
                        UIColor.rgb(155, green: 161, blue: 161)]))
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    
                    attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                }
                self.nameLabel.attributedText = attributedText
            }
        }
    }
    let thumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.init(white: 0.96, alpha: 1).cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.image = UIImage.init(named: "user-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.getAppRegularFont(size: 14)
        return titleLabel
    }()
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.getAppRegularFont(size: 14)
        textView.layer.cornerRadius = 3
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .all
        textView.backgroundColor = UIColor.init(white: 0.98, alpha: 1)
        textView.isEditable = false
        return textView
    }()
    let moreButton = WSMemberWallCell.buttonForTitle("", imageName: "more")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.thumbImageView)
        addSubview(self.nameLabel)
        addSubview(self.moreButton)
        addSubview(self.commentTextView)
        
        addConstraintsWithFormat("H:|-10-[v0(40)]-10-[v1][v2(60)]|", views: thumbImageView, nameLabel, moreButton)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: commentTextView)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: thumbImageView)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: nameLabel)
        addConstraintsWithFormat("V:|[v0(50)]|", views: moreButton)

        addConstraintsWithFormat("V:|-60-[v0]-10-|", views: commentTextView)

        self.thumbImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showUserProfile)))
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
    }
    
    @objc func moreAction() {
        controller?.moreAction(comment!)
    }

    @objc func showUserProfile() {
        controller?.showUserProfile((comment?.memberId)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

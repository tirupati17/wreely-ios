//
//  WSMemberWallPostCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import GrowingTextView

class WSMemberWallPostCell : WSTableViewCell {
    var controller: WSMemberWallPostView?
    
    @objc func showPreview() {
        controller?.showPreviewImage()
    }
}

class WSMemberWallPostTextViewCell : WSMemberWallPostCell {
    
    let textView : GrowingTextView = {
        let textView = GrowingTextView()
        textView.maxLength = 1024
        textView.trimWhiteSpaceWhenEndEditing = false
        textView.placeholder = "What's on your mind"
        textView.font = UIFont.getAppRegularFont(size: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.textView)        
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: textView)
        addConstraintsWithFormat("V:|-10-[v0]-10-|", views: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WSMemberWallPostAttachmentCell : WSMemberWallPostCell {
    var attachmentArray : [String]!
    let thumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 0
        imageView.image = UIImage.init(named: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    let titleLabel : UILabel = {
       let titleLabel = UILabel()
       titleLabel.font = UIFont.getAppRegularFont(size: 14)
       return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.thumbImageView)
        addSubview(self.titleLabel)

        addConstraintsWithFormat("H:|[v0(60)]-15-[v1]|", views: thumbImageView, titleLabel)
        addConstraintsWithFormat("V:|[v0(60)]|", views: thumbImageView)
        addConstraintsWithFormat("V:|-15-[v0(30)]-15-|", views: titleLabel)
        
        self.thumbImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showPreview)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

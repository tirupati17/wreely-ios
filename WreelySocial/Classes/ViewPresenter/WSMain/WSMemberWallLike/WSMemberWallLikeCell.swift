//
//  WSMemberWallLikeCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallLikeCell : WSTableViewCell {
    var controller: WSMemberWallLikeView?

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
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.getAppRegularFont(size: 14)
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.thumbImageView)
        addSubview(self.titleLabel)
        
        addConstraintsWithFormat("H:|-10-[v0(40)]-10-[v1]|", views: thumbImageView, titleLabel)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: thumbImageView)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: titleLabel)
        
        self.thumbImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showUserProfile)))
    }
    
    @objc func showUserProfile() {
        controller?.showUserProfile(0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

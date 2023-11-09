//
//  WSGroupListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSGroupListCell : WSTableViewCell {
    var controller: WSMemberWallCommentView?
    var member: WSMember? {
        didSet {
            self.thumbImageView.kf.setImage(with: URL.init(string: (member?.profilePicUrl!)!), placeholder: Image.init(named: "user-placeholder"))
            
            if let name = member?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.getAppMediumFont(size: 14)])
                
                attributedText.append(NSAttributedString(string: "\n Available", attributes: [NSAttributedString.Key.font: UIFont.getAppMediumFont(size: 12), NSAttributedString.Key.foregroundColor:
                    UIColor.rgb(155, green: 161, blue: 161)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                
                self.nameLabel.attributedText = attributedText
            }
        }
    }
    var vendor: WSVendor? {
        didSet {
            self.thumbImageView.kf.setImage(with: URL.init(string: (vendor?.vendorLogoUrl!)!), placeholder: Image.init(named: "user-placeholder"))
            
            if let name = vendor?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.getAppMediumFont(size: 14)])
                
                attributedText.append(NSAttributedString(string: "\n\(vendor?.totalMember! ?? 0) Members", attributes: [NSAttributedString.Key.font: UIFont.getAppMediumFont(size: 12), NSAttributedString.Key.foregroundColor:
                    UIColor.rgb(155, green: 161, blue: 161)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

                self.nameLabel.attributedText = attributedText
            }
        }
    }
    let thumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.borderColor = UIColor.init(white: 0.96, alpha: 1).cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.image = UIImage.init(named: "user-placeholder")
        imageView.contentMode = .scaleAspectFit
        
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.getAppRegularFont(size: 14)
        return titleLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.thumbImageView)
        addSubview(self.nameLabel)
        
        addConstraintsWithFormat("H:|-15-[v0(50)]-15-[v1]|", views: thumbImageView, nameLabel)
        addConstraintsWithFormat("V:|-15-[v0(50)]-15-|", views: thumbImageView)
        addConstraintsWithFormat("V:|-15-[v0(50)]-15-|", views: nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

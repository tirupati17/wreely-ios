//
//  MessageTableViewCell.swift
//
//  Created by Tirupati Balan on 20/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    var messageContainerView: MessageBubbleView!
    var messageLabel: UILabel!
    var timestampLabel: UILabel!
    var displayNameLabel: UILabel!
    var isOneToOneMode = true
    var isCurrentUser = true

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.messageContainerView = MessageBubbleView.init()
        self.messageContainerView.backgroundColor = UIColor.clear
        
        self.messageLabel = UILabel.init()
        self.messageLabel.font = UIFont.init(name: WSConstant.AppCustomFontRegular, size: 14) ?? UIFont.systemFont(ofSize: 14)
        self.messageLabel.textAlignment = .left
        self.messageLabel.numberOfLines = 1000

        self.timestampLabel = UILabel.init()
        self.timestampLabel.textAlignment = .right
        self.timestampLabel.font = UIFont.init(name: WSConstant.AppCustomFontRegular, size: 12) ?? UIFont.systemFont(ofSize: 12)

        self.displayNameLabel = UILabel.init()
        self.displayNameLabel.textAlignment = .left
        self.displayNameLabel.font = UIFont.init(name: WSConstant.AppCustomFontMedium, size: 12) ?? UIFont.systemFont(ofSize: 12)

        self.messageContainerView.addSubview(self.messageLabel)
        self.messageContainerView.addSubview(self.displayNameLabel)
        self.messageContainerView.addSubview(self.timestampLabel)
        
        self.addSubview(self.messageContainerView)
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    func configure(withMessage message: WSFIRMessages) {
        self.messageLabel.text = message.message
        self.displayNameLabel.text = message.userName
        self.isCurrentUser = message.isCurrentUser()

        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd MMM hh:mm a"
        self.timestampLabel.text = dateFormatter.string(from: Date.init(timeIntervalSince1970: Double(message.timestamp!/1000)))
        self.messageContainerView.currentUserIsSender = self.isCurrentUser
        
        if (self.isCurrentUser) {
            self.messageLabel.textAlignment = .left
        } else {
            self.messageLabel.textAlignment = .left
        }
    }
    
    override func draw(_ rect: CGRect) {
        //TODO : Please re-correct below padding/margin naming convention
        
        let messageContainerPadding : CGFloat = 5
        let messageContainerMargin : CGFloat = 10
        
        let messageLabelPaddingLeft : CGFloat = 5
        let messageLabelPaddingTop : CGFloat = 20
        let messageLabelMarginLeftRight : CGFloat = 10
        let messageLabelMarginTopBottom : CGFloat = 40

        let timestampLabelHeight : CGFloat = 20
        let displayLabelHeight : CGFloat = 20

        self.messageContainerView.frame = CGRect(origin: CGPoint(x: messageContainerPadding + (self.isCurrentUser ? 50 : 0), y: messageContainerPadding), size: CGSize(width: (rect.width - messageContainerMargin) - 50, height: rect.height - messageContainerMargin))
        
        self.messageLabel.frame = CGRect(origin: CGPoint(x: messageLabelPaddingLeft, y: messageLabelPaddingTop), size: CGSize(width: self.messageContainerView.width - messageLabelMarginLeftRight, height:self.messageContainerView.height - messageLabelMarginTopBottom))
        
        //Align it top left - right respectively
        self.timestampLabel.frame = CGRect(origin: CGPoint(x: self.messageContainerView.width/2, y: 0), size: CGSize(width: (self.messageContainerView.width/2 - 5), height:timestampLabelHeight)) //5 pix padding via width
        self.displayNameLabel.frame = CGRect(origin: CGPoint(x: 5, y: 0), size: CGSize(width: (self.messageContainerView.width/2 - 5), height:displayLabelHeight)) //5 pix padding via x and width adjustment
        
        self.messageLabel.textColor =  self.isCurrentUser ? UIColor.black : UIColor.black
        self.timestampLabel.textColor = self.isCurrentUser ? UIColor.darkGray : UIColor.darkGray
        self.displayNameLabel.textColor = UIColor.darkGray
        self.displayNameLabel.isHidden = self.isOneToOneMode || self.isCurrentUser
    }
}

class ChatLogMessageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCurrentUser = true
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.getAppRegularFont(size: 14)
        textView.text = ""
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.getAppBoldFont(size: 12)
        return titleLabel
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.grayBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
    func configure(withMessage message: WSFIRMessages) {
        self.messageTextView.text = message.message
        self.isCurrentUser = message.isCurrentUser()
        self.bubbleImageView.image = self.isCurrentUser ? ChatLogMessageCell.blueBubbleImage : ChatLogMessageCell.grayBubbleImage
    }
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-50-[v0]-30-|", views: nameLabel)
        addConstraintsWithFormat("V:|[v0(20)]|", views: nameLabel)

        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]-5-|", views: profileImageView)
        profileImageView.backgroundColor = UIColor.red
        
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintsWithFormat("H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintsWithFormat("V:|[v0]|", views: bubbleImageView)
    }
    
}


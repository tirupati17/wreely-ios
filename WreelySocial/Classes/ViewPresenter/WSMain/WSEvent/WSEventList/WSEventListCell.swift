//
//  WSEventListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material
import OnlyPictures

enum WSEventListCellUIControlTag : Int {
    case nameLabel = 111
    case timeLabel = 112
    case rsvpLabel = 113
    case descriptionLabel = 114
    case attendUnAttendButton = 115
    case dateLabel = 116
    case unknownType
}

class WSEventListCell : WSTableViewCell {
    @IBOutlet weak var onlyPictures: OnlyHorizontalPictures!
    var eventObj : WSEvent!
    override func awakeFromNib() {
        NSLog("Init something if you want")
    }
    
    func configureEventCell(_ event: WSEvent) {
        self.eventObj = event
        self.onlyPictures.dataSource = self
        self.onlyPictures.order = .ascending
        self.onlyPictures.recentAt = .right
        self.onlyPictures.alignment = .right
        self.onlyPictures.countPosition = .left
        self.onlyPictures.reloadData()
        self.onlyPictures.isHidden = true
        
        self.getLabel(WSEventListCellUIControlTag.dateLabel.rawValue).text = event.startTime?.toServerDate.toNormalDateString

        self.getLabel(WSEventListCellUIControlTag.nameLabel.rawValue).text = event.title
        self.getLabel(WSEventListCellUIControlTag.timeLabel.rawValue).text = (event.startTime?.toServerDate.toTimeString)! + " - " + (event.endTime?.toServerDate.toTimeString)!
        self.getLabel(WSEventListCellUIControlTag.rsvpLabel.rawValue).text = (event.totalRsvp?.toString())! + " RSVP"
        let textView = self.getView(WSEventListCellUIControlTag.descriptionLabel.rawValue) as! UITextView
        
        textView.attributedText = event.description?.html2AttributedString
        
        let button = self.getButton(WSEventListCellUIControlTag.attendUnAttendButton.rawValue) as! WSButton
        button.setTitle(event.isAttending == 1 ? "UNATTEND" : "ATTEND", for: .normal)
        button.setTitleColor(event.isAttending == 1 ? UIColor.lightGray : UIColor.black, for: .normal)
        button.layer.borderColor = event.isAttending == 1 ? UIColor.lightGray.cgColor : UIColor.black.cgColor
        button.layer.borderWidth = 1
    }
}

extension WSEventListCell : OnlyPicturesDataSource {
    func numberOfPictures() -> Int {
        return self.eventObj.totalRsvp!
    }
    
    func visiblePictures() -> Int {
        return self.eventObj.totalRsvp!// >= 5 ? 5 : self.eventObj.totalRsvp!
    }
    
    func pictureViews(index: Int) -> UIImage {
        return UIImage.init()
    }
    
    func pictureViews(_ imageView: UIImageView, index: Int) {
        //let url = URL(string: self.pictures[index])
        
        imageView.image = UIImage.init(named: "user-placeholder")   // placeholder image
        //imageView.af_setImage(withURL: url!)
    }
}

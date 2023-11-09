//
//  WSMemberListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSMemberListCellType : Int {
    case unknownType
}

enum WSMemberListCellUIControlTag : Int {
    case unknownType
}

class WSMemberListCell : UICollectionViewCell {
    var cellType : WSMemberListCellType!
    @IBOutlet var memberImageView : UIImageView!
    @IBOutlet var memberNameLabel : UILabel!
    @IBOutlet var outerView : UIView!
    
    override func awakeFromNib() {
//        self.outerView.WSRoundedView()
//        self.outerView.WSShadow()

        self.memberImageView.clipsToBounds = true
        self.memberImageView.layer.cornerRadius = self.memberImageView.frame.size.width/2
    }
}

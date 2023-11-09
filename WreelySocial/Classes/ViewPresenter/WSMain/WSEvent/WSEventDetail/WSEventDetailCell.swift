//
//  WSEventDetailCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSEventDetailCellType : Int {
    case unknownType
}

enum WSEventDetailCellUIControlTag : Int {
    case unknownType
}

class WSEventDetailCell : UITableViewCell {
    var cellType : WSEventDetailCellType!
    @IBOutlet var logoImageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var outerView : UIView!
    
    override func awakeFromNib() {
        
    }
}

//
//  WSCompanyDetailCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSCompanyDetailCellType : Int {
    case unknownType
}

enum WSCompanyDetailCellUIControlTag : Int {
    case unknownType
}

class WSCompanyDetailCell : UITableViewCell {
    var cellType : WSCompanyDetailCellType!
    @IBOutlet var logoImageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var outerView : UIView!
    
    override func awakeFromNib() {
        
    }
}

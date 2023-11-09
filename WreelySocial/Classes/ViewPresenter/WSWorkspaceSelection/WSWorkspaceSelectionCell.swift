//
//  WSWorkspaceSelectionCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSWorkspaceSelectionCellType : Int {
    case unknownType
}

enum WSWorkspaceSelectionCellUIControlTag : Int {
    case unknownType
}

class WSWorkspaceSelectionCell : UITableViewCell {
    var cellType : WSWorkspaceSelectionCellType!
    @IBOutlet var vendorLogoImageView : UIImageView!
    @IBOutlet var vendorNameLabel : UILabel!
    @IBOutlet var vendorLocationLabel : UILabel!
    @IBOutlet var outerView : UIView!
    @IBOutlet var upperOuterView : UIView!

    override func awakeFromNib() {

        self.upperOuterView.layer.cornerRadius = 5
        self.outerView.layer.cornerRadius = self.vendorLogoImageView.height/2
        self.vendorLogoImageView.layer.cornerRadius = self.vendorLogoImageView.height/2
    }
}

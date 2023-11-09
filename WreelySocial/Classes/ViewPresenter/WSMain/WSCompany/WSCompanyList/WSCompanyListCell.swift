//
//  WSCompanyListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSCompanyListCellType : Int {
    case unknownType
}

enum WSCompanyListCellUIControlTag : Int {
    case unknownType
}

class WSCompanyListCell : UICollectionViewCell {
    var cellType : WSCompanyListCellType!
    @IBOutlet var companyLogoImageView : UIImageView!
    @IBOutlet var companyNameLabel : UILabel!
    @IBOutlet var outerView : UIView!

    override func awakeFromNib() {
        NSLog("Init something if you want")
        
//        self.outerView.WSRoundedView()
//        self.outerView.WSShadow()
        /* Create shadow extention of UIView - START */

        /* Create shadow extention of UIView - END */

        self.companyLogoImageView.clipsToBounds = true
        self.companyLogoImageView.layer.cornerRadius = self.companyLogoImageView.frame.size.width/2
    }
}

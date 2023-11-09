//
//  WSTableViewCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSTableViewCell : UITableViewCell {
    
    func getButton(_ tag : Int) -> UIButton {
        return self.viewWithTag(tag) as! UIButton
    }
    
    func getLabel(_ tag : Int) -> UILabel {
        return self.viewWithTag(tag) as! UILabel
    }
    
    func getField(_ tag : Int) -> UITextField {
        return self.viewWithTag(tag) as! UITextField
    }
    
    func getView(_ tag : Int) -> UIView {
        return self.viewWithTag(tag)!
    }
    
}

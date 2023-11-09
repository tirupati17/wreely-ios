//
//  WSLoginCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSLoginCellFieldType : Int {
    case emailFieldType = 0
    case passwordFieldType = 1
    case unknownFieldType = 3
}

enum WSLoginCellUIControlTag : Int {
    case emailFieldTag = 111
    case passwordFieldTag = 221
    case forgotPassButtonTag = 222
    case loginButtonTag = 331
}

class WSLoginCell : WSTableViewCell {
    var cellFieldType : WSLoginCellFieldType!
    convenience override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

class WSLoginTextFieldCell : WSLoginCell {

    func emailField() -> ErrorTextField {
        return self.viewWithTag(WSLoginCellUIControlTag.emailFieldTag.rawValue) as! ErrorTextField
    }
    
    func passwordField() -> ErrorTextField {
        return self.viewWithTag(WSLoginCellUIControlTag.passwordFieldTag.rawValue) as! ErrorTextField
    }
    
    func forgotPassButton() -> UIButton {
        return self.viewWithTag(WSLoginCellUIControlTag.forgotPassButtonTag.rawValue) as! UIButton
    }

    func getField(_ tag : WSLoginCellUIControlTag) -> ErrorTextField {
        return self.viewWithTag(tag.rawValue) as! ErrorTextField
    }
}

class WSLoginButtonCell : WSLoginCell {
    func signInButton() -> UIButton {
        return self.viewWithTag(WSLoginCellUIControlTag.loginButtonTag.rawValue) as! UIButton
    }
    
    func getButton(_ controlTag : WSLoginCellUIControlTag) -> UIButton {
        return self.viewWithTag(controlTag.rawValue) as! UIButton
    }
}


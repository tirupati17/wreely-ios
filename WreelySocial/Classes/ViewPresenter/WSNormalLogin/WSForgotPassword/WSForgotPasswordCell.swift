//
//  ForgotPasswordCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSForgotPasswordCellFieldType : Int {
    case emailFieldType = 0
    case unknownFieldType = 2
}

enum WSForgotPasswordCellUIControlTag : Int {
    case emailFieldTag = 111
    case submitButtonTag = 221
    case signInButtonTag = 222
    case unknownTag = 0
}

class WSForgotPasswordCell : WSTableViewCell {
    var cellFieldType : WSForgotPasswordCellFieldType!
    convenience override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

class WSForgotPasswordTextFieldCell : WSForgotPasswordCell {
    //used during programmatically without storyboard - START
    var textField : UITextField!
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setTextFieldText(_ text : String) {
        self.textField.text = text
    }
    //used during programmatically without storyboard - END
    
    func emailField() -> ErrorTextField {
        return self.viewWithTag(WSForgotPasswordCellUIControlTag.emailFieldTag.rawValue) as! ErrorTextField
    }
    
    func getField(_ fieldType : WSForgotPasswordCellFieldType) -> ErrorTextField {
        let tag = fieldType == WSForgotPasswordCellFieldType.emailFieldType ? WSForgotPasswordCellUIControlTag.emailFieldTag : WSForgotPasswordCellUIControlTag.unknownTag

        return self.viewWithTag(tag.rawValue) as! ErrorTextField
    }
}

class WSForgotPasswordButtonCell : WSForgotPasswordCell {
    
    func submitButton() -> UIButton {
        return self.viewWithTag(WSForgotPasswordCellUIControlTag.submitButtonTag.rawValue) as! UIButton
    }

    func signInButton() -> UIButton {
        return self.viewWithTag(WSForgotPasswordCellUIControlTag.signInButtonTag.rawValue) as! UIButton
    }

    func getButton(_ controlTag : WSLoginCellUIControlTag) -> UIButton {
        return self.viewWithTag(controlTag.rawValue) as! UIButton
    }
}

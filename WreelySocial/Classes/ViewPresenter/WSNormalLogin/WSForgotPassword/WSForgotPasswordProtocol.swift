//
//  WSForgotPasswordProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation

/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */

protocol WSForgotPasswordViewProtocol {
    func validationForField(_ fieldType: WSForgotPasswordCellFieldType)
    func submittedSuccessful()
    func submitionFailed()
    func stopViewAnimation()
    func startViewAnimation()
}

//
//  WSLoginProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

/**
 * Add here your methods for communication between PRESENTER -> VIEW
 */

protocol WSLoginViewProtocol {
    func validationForField(_ fieldType: WSLoginCellFieldType)
    func loginSuccessful()
    func loginFailed(_ error : Error)
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
}

/**
 * Add here your methods for communication between VIEW -> PRESENTER
 */

protocol WSLoginPresenterProtocol {
    func didLoginPressed(_ email : String , password : String)
    func showMainView()
    func showWorkspaceSelectionView()
    func showForgotPasswordView()
}

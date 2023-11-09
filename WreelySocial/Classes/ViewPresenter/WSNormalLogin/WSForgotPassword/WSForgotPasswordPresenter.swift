//
//  WSForgotPasswordPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import NVActivityIndicatorView

class WSForgotPasswordPresenter {
    var forgotPasswordViewProtocol : WSForgotPasswordViewProtocol!
    
    func getView() -> WSForgotPasswordView {
        return (self.forgotPasswordViewProtocol as? WSForgotPasswordView)!
    }
    
    func didForgotPasswordPressed() {
        if self.getView().emailField().isEmpty {
            self.forgotPasswordViewProtocol.validationForField(.emailFieldType)
            return
        }
        self.forgotPasswordViewProtocol.startViewAnimation()
        WSRequest.userForgotPassword(self.getView().emailField().text!, { () in
            self.forgotPasswordViewProtocol.submittedSuccessful()
        }) { (error) in
            self.forgotPasswordViewProtocol.submitionFailed()
        }
    }
}

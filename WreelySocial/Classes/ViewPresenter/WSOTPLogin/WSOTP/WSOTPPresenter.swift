//
//  WSOTPPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSOTPPresenter {
    var otpViewProtocol : WSOTPViewProtocol!
}

extension WSOTPPresenter : WSOTPPresenterProtocol {
    func sendNumberForOTP(_ countryCode: String, mobile: String) {
        WSRequest.userOTPLogin(countryCode, mobile, { (response) in
            self.otpViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.otpViewProtocol.didFailedResponse(error)
        }
    }
    
    func showOTPConfirmationView(_ viewItem : WSOTPConfirmationViewItem) {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSOTPConfirmationView.storyboardIdentifier) as! WSOTPConfirmationView
        vc.otpConfirmationViewItem = viewItem
        self.otpViewProtocol.pushController(vc)
    }
}

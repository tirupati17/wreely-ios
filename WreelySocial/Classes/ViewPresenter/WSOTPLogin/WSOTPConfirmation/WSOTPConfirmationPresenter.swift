//
//  WSOTPConfirmationPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSOTPConfirmationPresenter {
    var otpConfirmationViewProtocol : WSOTPConfirmationViewProtocol!
}

extension WSOTPConfirmationPresenter : WSOTPConfirmationPresenterProtocol {
    func confirmOTP(_ viewItem : WSOTPConfirmationViewItem) {
        WSRequest.userOTPConfirmation(viewItem.otpCode, "\(viewItem.memberId)", { (response) in
            self.otpConfirmationViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.otpConfirmationViewProtocol.didFailedResponse(error)
        }
    }
    
    func resendOTP(_ mobileNumber : String) {
        WSRequest.userOTPLogin("+91", mobileNumber, { (response) in
            self.otpConfirmationViewProtocol.didSuccessfulResentResponse(response)
        }) { (error) in
            self.otpConfirmationViewProtocol.didFailedResponse(error)
        }
    }

    func fetchValidUser() {
        WSRequest.fetchCurrentMember({ (object) in
            self.otpConfirmationViewProtocol.didValidUser()
        }) { (error) in
            self.otpConfirmationViewProtocol.didFailedResponse(error)
        }
    }
    
    func showWorkspaceSelection() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSWorkspaceSelectionView.storyboardIdentifier) as! WSWorkspaceSelectionView
        self.otpConfirmationViewProtocol.presentController(vc)
    }
}

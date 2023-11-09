//
//  WSLoginPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import NVActivityIndicatorView

class WSLoginPresenter {
    var loginViewProtocol : WSLoginViewProtocol!
    
    func getView() -> WSLoginView {
        return (self.loginViewProtocol as? WSLoginView)!
    }
}

extension WSLoginPresenter : WSLoginPresenterProtocol {
    func didLoginPressed(_ email : String , password : String) {
        Defaults[.username] = email
        Defaults[.password] = password
        
        WSRequest.userLogin(email, password, { (user) in
            WSRequest.updateDataForCurrentUser(["lastLoginAt": Date.init().getCurrentDateString as AnyObject, "device": UIDevice.init().modelName as AnyObject])
            WSRequest.fetchFirebaseCurrentUser({ () in
                self.loginViewProtocol.loginSuccessful()
            })
        }) { (error) in
            self.loginViewProtocol.loginFailed(error as! Error)
        }
    }
    
    func showMainView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSCompanyListView.storyboardIdentifier)
        let nv = WSNavigationController.init(rootViewController: vc)
        self.loginViewProtocol.presentController(nv)
    }
    
    func showWorkspaceSelectionView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSWorkspaceSelectionView.storyboardIdentifier)
        self.loginViewProtocol.presentController(vc)
    }
    
    func showForgotPasswordView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSForgotPasswordView.storyboardIdentifier)
        self.loginViewProtocol.pushController(vc)
    }

}

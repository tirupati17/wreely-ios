//
//  WSSplashPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WSSplashPresenter {
    var splashViewProtocol : WSSplashViewProtocol!
}

extension WSSplashPresenter : WSSplashPresenterProtocol {
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */

    func fetchValidSession() {
        if WSSession.activeSession().isValidSession() {
            self.splashViewProtocol.didValidSession()
        } else {
            self.splashViewProtocol.didFailedResponse()
        }
    }
    
    func fetchValidUser() {
        WSRequest.fetchCurrentMember({ (object) in
            self.splashViewProtocol.didValidUser()
        }) { (error) in
            self.splashViewProtocol.didFailedResponse()
        }
    }
    
    func showLoginView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSOTPView.storyboardIdentifier)
        self.splashViewProtocol.pushController(vc)
    }
    
    func showWorkspaceSelectionView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSWorkspaceSelectionView.storyboardIdentifier)
        AppDelegate.sharedDelegate.window?.rootViewController?.present(vc, animated: true, completion: {
            
        })
    }
}


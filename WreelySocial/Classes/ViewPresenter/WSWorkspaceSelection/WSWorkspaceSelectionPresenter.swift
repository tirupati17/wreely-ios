//
//  WSWorkspaceSelectionPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class WSWorkspaceSelectionPresenter {
    var workspaceSelectionViewProtocol : WSWorkspaceSelectionViewProtocol!
    
}

extension WSWorkspaceSelectionPresenter : WSWorkspaceSelectionPresenterProtocol {
    func didFetchVendors() {
        WSRequest.fetchVendors([:], success: { (response) in
            self.workspaceSelectionViewProtocol.updateVendors(response as! [WSVendor])
        }) { (error) in
            self.workspaceSelectionViewProtocol.didFailedResponse(error)
        }
    }
    
    func didSelectWorkspace(vendor : WSVendor) { //App main view entry point
        WSTracking.sharedTracking.setupInitialTracking()
        WSSessionManager.sessionManager.setCurrentVendor(vendor)
        
        AppDelegate.sharedDelegate.firebaseLogin()
        
        let tabbar = SWTabBar.init()
        let menuItems = tabbar.createTabData()
        let tabController  = SWTabBarController(incomingArray: menuItems)
        
        self.workspaceSelectionViewProtocol.presentController(tabController)
    }
    
}

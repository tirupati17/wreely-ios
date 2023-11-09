//
//  WSSplashView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WSSplashView: WSViewController {
    var splashPresenterProtocol : WSSplashPresenterProtocol!

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependencies()
        self.startViewAnimation()
        self.splashPresenterProtocol.fetchValidSession()
    }
    
    func configureDependencies() {
        let splashPresenter = WSSplashPresenter()
        splashPresenter.splashViewProtocol = self //attache splash view protocol to self view
        self.splashPresenterProtocol = splashPresenter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return !UIApplication.shared.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSSplashView : WSSplashViewProtocol {
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: false)
    }
    
    func didValidSession() {
        self.splashPresenterProtocol.fetchValidUser()
    }
    
    func didValidUser() {
        self.stopViewAnimation()
        self.splashPresenterProtocol.showWorkspaceSelectionView()
    }
    
    func didFailedResponse() {
        self.stopViewAnimation()
        self.splashPresenterProtocol.showLoginView()
    }
 }

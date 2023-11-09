//
//  WSSplashProtocols.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation

/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */

protocol WSSplashViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func didValidSession()
    func didValidUser()
    func didFailedResponse()
}

protocol WSSplashPresenterProtocol {
    func fetchValidSession()
    func fetchValidUser()
    func showLoginView()
    func showWorkspaceSelectionView()
}

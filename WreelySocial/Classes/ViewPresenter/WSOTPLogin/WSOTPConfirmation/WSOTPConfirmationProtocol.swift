//
//  WSOTPConfirmationProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

/**
 * Add here your methods for communication between PRESENTER -> VIEW
 */

protocol WSOTPConfirmationViewProtocol {
    func didSuccessfulResponse<T>(_ response: T)
    func didFailedResponse<T>(_ error : T)
    func didSuccessfulResentResponse<T>(_ response: T)
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func didValidUser()
}

/**
 * Add here your methods for communication between VIEW -> PRESENTER
 */

protocol WSOTPConfirmationPresenterProtocol {
    func fetchValidUser()
    func confirmOTP(_ viewItem : WSOTPConfirmationViewItem)
    func resendOTP(_ mobileNumber : String)
    func showWorkspaceSelection()
}

//
//  WSOTPProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

/**
 * Add here your methods for communication between PRESENTER -> VIEW
 */

protocol WSOTPViewProtocol {
    func didSuccessfulResponse<T>(_ response: T)
    func didFailedResponse<T>(_ error : T)
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
}

/**
 * Add here your methods for communication between VIEW -> PRESENTER
 */

protocol WSOTPPresenterProtocol {
    func sendNumberForOTP(_ countryCode : String, mobile : String)
    func showOTPConfirmationView(_ viewItem : WSOTPConfirmationViewItem)
}

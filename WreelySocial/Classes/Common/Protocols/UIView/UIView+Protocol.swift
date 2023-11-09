//
//  UIView+Protocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol UIViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func didSuccessfulResponse<T>(_ response: T)
    func didFailedResponse<T>(_ error : T)
}

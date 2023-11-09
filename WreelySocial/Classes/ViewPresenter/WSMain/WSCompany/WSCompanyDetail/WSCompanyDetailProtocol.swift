//
//  WSCompanyDetailProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSCompanyDetailViewProtocol {
    func noContentFromServer()
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateView(_ company : WSCompany)
    func stopViewAnimation()
    func startViewAnimation()
}

protocol WSCompanyDetailPresenterProtocol {
    func didFetchMoreDetail()
}

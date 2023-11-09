//
//  WSCompanyListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation

protocol WSCompanyListViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateCompanies(_ companies : [WSCompany])
    func didFailedResponse(_ error : Error)
}

protocol WSCompanyListPresenterProtocol {
    func didSelectCompany(company : WSCompany?)
    func didFetchCompanies()
    func didSideMenuPressed()
}

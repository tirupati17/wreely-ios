//
//  WSCompanyListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSCompanyListPresenter {
    var companyListViewProtocol : WSCompanyListViewProtocol!
}

extension WSCompanyListPresenter : WSCompanyListPresenterProtocol {
    func didSideMenuPressed() {
        
    }

    func didSelectCompany(company : WSCompany?) {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSCompanyDetailView.storyboardIdentifier) as! WSCompanyDetailView
        vc.company = company
        self.companyListViewProtocol.pushController(vc)
    }
    
    func didFetchCompanies() {
        WSRequest.fetchCompanies({ (object) in
            self.companyListViewProtocol.updateCompanies(object as! [WSCompany])
        }) { (error) in
            self.companyListViewProtocol.didFailedResponse(error)
        }
    }
}


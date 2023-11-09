//
//  WSGroupListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSGroupListPresenter {
    var groupListViewProtocol : WSGroupListViewProtocol!
}

extension WSGroupListPresenter : WSGroupListPresenterProtocol {
    func didFetchVendors() {
        WSRequest.fetchVendors([:], success: { (response) in
            self.groupListViewProtocol.updateGroupList(response as! [WSVendor])
        }) { (error) in
            self.groupListViewProtocol.didFailedResponse(error)
        }
    }
    
    func didFetchMembers() {
        WSRequest.fetchMembers({ (response) in
            self.groupListViewProtocol.updateMembers(response as! [WSMember])
        }) { (error) in
            self.groupListViewProtocol.didFailedResponse(error)
        }
    }
    
}

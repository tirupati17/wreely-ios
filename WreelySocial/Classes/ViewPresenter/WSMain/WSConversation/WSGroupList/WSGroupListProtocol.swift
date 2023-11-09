//
//  WSGroupListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSGroupListViewProtocol : UIViewControllerProtocol {
    func updateGroupList(_ response: [WSVendor])
    func updateMembers(_ members : [WSMember])
    func didSuccessfulResponse<T>(_ response: T)
}

protocol WSGroupListPresenterProtocol {
    func didFetchVendors()
    func didFetchMembers()
}

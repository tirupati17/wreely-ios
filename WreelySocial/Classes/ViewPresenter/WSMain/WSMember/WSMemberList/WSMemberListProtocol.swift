//
//  WSMemberListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSMemberListViewProtocol : UIViewControllerProtocol {
    func updateMembers(_ members : [WSMember])
}

protocol WSMemberListPresenterProtocol {
    func didSelectMember(member : WSMember?)
    func didFetchMembers()
    func didSideMenuPressed()
}

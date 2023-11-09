//
//  WSMemberListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMemberListPresenter {
    var memberListViewProtocol : WSMemberListViewProtocol!
}

extension WSMemberListPresenter : WSMemberListPresenterProtocol {
    func didSideMenuPressed() {
        
    }
    
    func didSelectMember(member : WSMember?) {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMemberDetailView.storyboardIdentifier) as! WSMemberDetailView
        vc.member = member
        self.memberListViewProtocol.pushController(vc)
    }
    
    func didFetchMembers() {
        WSRequest.fetchMembers({ (object) in
            self.memberListViewProtocol.updateMembers(object as! [WSMember])
        }) { (error) in
            self.memberListViewProtocol.didFailedResponse(error)
        }
    }
}

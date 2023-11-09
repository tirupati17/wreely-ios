//
//  WSMemberDetailPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberDetailPresenter  {
    var memberDetailViewProtocol : WSMemberDetailViewProtocol!
    
}

extension WSMemberDetailPresenter : WSMemberDetailPresenterProtocol {
    
    func didFetchMoreDetail() {
        WSRequest.fetchCurrentMember({ (object) in
            self.memberDetailViewProtocol.updateView(WSSession.activeSession().currentUser())
        }) { (error) in

        }
    }
}

//
//  WSMemberWallPostPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallPostPresenter {
    var memberWallPostViewProtocol : WSMemberWallPostViewProtocol!
}

extension WSMemberWallPostPresenter : WSMemberWallPostPresenterProtocol {
    func submitPost(memberWallPostViewItem : WSMemberWallPostViewItem) {
        WSRequest.submitPost(["image_url" : memberWallPostViewItem.statusImageUrl ?? "", "post_description" : memberWallPostViewItem.statusText ?? "", "post_by_member_id" : WSSession.activeSession().currentUser().id?.toString() as Any], success: { (response) in
            self.memberWallPostViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.memberWallPostViewProtocol.didFailedResponse(error)
        }
    }
}


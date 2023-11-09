//
//  WSMemberWallLikePresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallLikePresenter {
    var memberWallLikeViewProtocol : WSMemberWallLikeViewProtocol!
}

extension WSMemberWallLikePresenter : WSMemberWallLikePresenterProtocol {
    func fetchLikes(forPost: WSMemberWall) {
        WSRequest.fetchMemberWallFeedLikeList(["post_id":"\(forPost.id!)"], success: { (response) in
            self.memberWallLikeViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.memberWallLikeViewProtocol.didFailedResponse(error)
        }
    }
}

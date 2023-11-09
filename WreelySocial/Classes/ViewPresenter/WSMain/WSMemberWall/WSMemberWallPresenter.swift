//
//  WSMemberWallPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallPresenter {
    var memberWallViewProtocol : WSMemberWallViewProtocol!
}

extension WSMemberWallPresenter : WSMemberWallPresenterProtocol {
    
    func didDeleteWallPost(wallPost : WSMemberWall) {
        WSRequest.deleteMemberWallPost(["post_id":"\(wallPost.id!)", "post_by_member_id":"\(WSSession.activeSession().currentUser().id!)"], success: { (response) in
            print(response)
        }) { (error) in
            self.memberWallViewProtocol.didFailedResponse(error)
        }
    }

    func didSelectWallPost(wallPost : WSMemberWall) {
        
    }
    
    func didUpdateLike(forPost : WSMemberWall) {
        WSRequest.updatePostLike(["post_id":"\(forPost.id!)", "like_by_member_id":"\(WSSession.activeSession().currentUser().id!)"], success: { (response) in
            self.memberWallViewProtocol.updateLikeStatus()
        }, failure: { (error) in
            self.memberWallViewProtocol.didFailedResponse(error)
        })
    }
    
    func didFetchWallFeeds() {
        WSRequest.fetchMemberWallFeeds(["is_member_feeds": false], success: { (response) in
            self.memberWallViewProtocol.updateWallPost(response as! [WSMemberWall])
        }) { (error) in
            self.memberWallViewProtocol.didFailedResponse(error)
        }
    }

}

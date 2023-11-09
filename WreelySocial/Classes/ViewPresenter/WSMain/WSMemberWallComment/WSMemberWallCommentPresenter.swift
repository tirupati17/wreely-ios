//
//  WSMemberWallCommentPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMemberWallCommentPresenter {
    var memberWallCommentViewProtocol : WSMemberWallCommentViewProtocol!
}

extension WSMemberWallCommentPresenter : WSMemberWallCommentPresenterProtocol {
    func didFetchComment(forPost: WSMemberWall) {
        WSRequest.fetchMemberWallFeedCommentList(["post_id":"\(forPost.id!)"], success: { (response) in
            self.memberWallCommentViewProtocol.updateCommentList(response as! [WSMemberWallComments])
        }) { (error) in
            self.memberWallCommentViewProtocol.didFailedResponse(error)
        }
    }
    
    func didSendComment(data : [String : Any]) {
        WSRequest.submitPostComment(data, success: { (response) in
            self.memberWallCommentViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.memberWallCommentViewProtocol.didFailedResponse(error)
        }
    }
    
    func didDeleteComment(comment : WSMemberWallComments) {
        WSRequest.deleteMemberWallFeedComment(["comment_id":"\(comment.id!)"], success: { (response) in
            self.memberWallCommentViewProtocol.didSuccessfulResponse(response)
        }) { (error) in
            self.memberWallCommentViewProtocol.didFailedResponse(error)
        }
    }

}

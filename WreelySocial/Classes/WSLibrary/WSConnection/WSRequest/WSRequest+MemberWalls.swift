//
//  WSRequest+MemberWalls.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 03/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchMemberWallFeeds(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMemberWallFeeds(data, success: success, failure: failure)
    }
    
    class func fetchMemberWallFeedLikeList(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMemberWallFeedLikeList(data, success: success, failure: failure)
    }
    
    class func fetchMemberWallFeedCommentList(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMemberWallFeedCommentList(data, success: success, failure: failure)
    }
    
    class func submitPost(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.createMemberWallPost(data, success: success, failure: failure)
    }

    class func updatePostLike(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.createMemberWallFeedLike(data, success: success, failure: failure)
    }
    
    class func submitPostComment(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.createMemberWallFeedComment(data, success: success, failure: failure)
    }

    class func deleteMemberWallPost(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.deleteMemberWallPost(data, success: success, failure: failure)
    }

    class func deleteMemberWallFeedComment(_ data : [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.deleteMemberWallFeedComment(data, success: success, failure: failure)
    }

}

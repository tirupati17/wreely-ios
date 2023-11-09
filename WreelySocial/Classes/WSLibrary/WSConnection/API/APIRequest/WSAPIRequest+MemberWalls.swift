//
//  WSAPIRequest+MemberWalls.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    
    class func getMemberWallFeeds(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMemberWallFeeds)
        let urlString = WSAPIStringUrl.getMemberWallFeedsEndpoint("10", page_number: "1", is_member_feeds: parameters["is_member_feeds"] as! Bool)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func getMemberWallFeedCommentList(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMemberWallFeedCommentList)
        let urlString = WSAPIStringUrl.getMemberWallFeedCommentListEndpoint(parameters["post_id"] as! String, per_page: "10", page_number: "1")
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func getMemberWallFeedLikeList(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMemberWallFeedLikeList)
        let urlString = WSAPIStringUrl.getMemberWallFeedLikeListEndpoint(parameters["post_id"] as! String, per_page: "10", page_number: "1")
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func deleteMemberWallPost(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestDeleteMemberWallPost)
        let urlString = WSAPIStringUrl.deleteMemberWallPostEndpoint(parameters["post_id"] as! String, post_by_member_id: parameters["post_by_member_id"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func deleteMemberWallFeedComment(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestDeleteMemberWallFeedComment)
        let urlString = WSAPIStringUrl.deleteMemberWallFeedCommentEndpoint(parameters["comment_id"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func deleteMemberWallFeedLike(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestCreateMemberWallFeedLike)
        let urlString = WSAPIStringUrl.deleteMemberWallFeedLikeEndpoint(parameters["like_id"] as! String)
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func createMemberWallPost(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestCreateMemberWallPost)
        let urlString = WSAPIStringUrl.createMemberWallPostEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func createMemberWallFeedComment(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestCreateMemberWallFeedComment)
        let urlString = WSAPIStringUrl.createMemberWallFeedCommentEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func createMemberWallFeedLike(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestCreateMemberWallFeedLike)
        let urlString = WSAPIStringUrl.createMemberWallFeedLikeEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
}

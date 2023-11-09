//
//  WSAPIRequest+Members.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    
    class func getMembers(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMembers)
        let urlString = WSAPIStringUrl.getMembersEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
}

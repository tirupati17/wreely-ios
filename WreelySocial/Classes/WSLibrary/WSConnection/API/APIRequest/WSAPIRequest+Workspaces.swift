//
//  WSAPIRequest+Workspaces.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    class func getNearbyWorkspaces(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestNearByWorkspaces)
        let urlString = WSAPIStringUrl.getNearByWorkspaces(parameters["lat"] as! String, lon: parameters["lon"] as! String, rad: parameters["rad"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
}

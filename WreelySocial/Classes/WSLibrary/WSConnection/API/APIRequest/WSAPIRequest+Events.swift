//
//  WSAPIRequest+Events.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    class func getEvents(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestEvents)
        let urlString = WSAPIStringUrl.getEventsEndpoint(parameters["page_number"] as! String, page_number: parameters["per_page"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func getAttendEvent(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestEventAttend)
        let urlString = WSAPIStringUrl.getEventAttend(parameters["event_id"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func getUnAttendEvent(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestEventUnAttend)
        let urlString = WSAPIStringUrl.getEventUnAttend(parameters["event_id"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }

}

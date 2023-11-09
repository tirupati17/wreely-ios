//
//  WSAPIRequest+Companies.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    
    class func getCompanies(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestCompanies)
        let urlString = WSAPIStringUrl.getCompaniesEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
}

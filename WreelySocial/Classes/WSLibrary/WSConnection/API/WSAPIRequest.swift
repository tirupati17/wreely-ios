//
//  WSAPIRequest.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
typealias JSONArray = Array<JSON>

class WSAPIRequest {
    var urlString: String?
    var params: [String: Any] = [:]
    var requestType: WSAPIRequestType?
    var requestMethod: WSRequestMethod?
    var dataRequest: DataRequest!
    var completed:Bool? = false
    var data:NSData?
    
    init(requestType : WSAPIRequestType? = nil) {
        self.requestType = requestType
    }
    
    func performRequest() {
        self.performRequestWith(success: nil, failure: nil)
    }
    
    func performRequestWith(success:((JSON) -> Void)!, failure:((Error) -> Void)!) {
        self.dataRequest = WSConnectionManager.sharedInstance.connectionWithRequest(self, success: success, failure: failure)
    }
    
    func cancelRequest() {
        self.dataRequest.cancel()
    }
    
    func requestWithUrlString(_ urlString:String? = "", requestMethod: WSRequestMethod? = nil, params:[String:Any]? = [:], data:NSData?, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        self.urlString = urlString
        self.params = params!
        self.requestMethod = requestMethod
        self.data = data
        self.performRequestWith(success: success!, failure: failure)
    }
    
}

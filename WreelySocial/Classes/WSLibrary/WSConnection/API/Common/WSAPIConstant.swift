//
//  WSAPIConstant.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation

#if BETA
let isProduction = false
#else
let isProduction = true
#endif

enum DeploymentType : Int {
    case kLocal = 1
    case kProduction = 2
    case kStaging = 3
}

class WSAPIConstant {
    class func baseUrl() -> String {
        if (isProduction) {
            return WSAPIConstant.productionUrl
        } else {
            return WSAPIConstant.localUrl
        }
    }
    
    static let baseWebUrl = "http://api.wreely.com"
    static let baseProductionUrl = "http://api.wreely.com"
    static let baseStagingUrl = "http://api.wreely.com"
    
    static let apiVersion1 = "v1/"
    static let apiVersion2 = "v2/"

    static let localUrl = "http://localhost/wreely/"
    static let stagingUrl = "http://smoke.wreely.com/services/"
    static let productionUrl = "http://api.wreely.com/services/" //remove services from base url asap
}



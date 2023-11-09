//
//  WSRequest+Companies.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchCompaniesForCurrentUser( _ success:((Any?) -> Void)!) {
        return WSFirebaseRequest().firebaseFetchCompaniesForCurrentUser(success)
    }
    
    class func fetchCompanies(_ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        return WSAPIRequest.getCompanies([:], success: success, failure: failure)
    }
}

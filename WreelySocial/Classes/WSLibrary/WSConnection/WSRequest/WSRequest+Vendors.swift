//
//  WSRequest+Vendors.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchWorkspacesForCurrentUser( _ success:((Any?) -> Void)!) {
        return WSFirebaseRequest().firebaseFetchWorkspaceForCurrentUser(success)
    }
    
    class func fetchVendors(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        return WSAPIRequest.getVendors(parameter, success: success, failure: failure)
    }

}

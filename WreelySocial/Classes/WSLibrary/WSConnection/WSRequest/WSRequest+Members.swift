//
//  WSRequest+Members.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchMembersForCurrentUser( _ success:((Any?) -> Void)!) {
        return WSFirebaseRequest().firebaseFetchMembersForCurrentUser(success)
    }
    
    class func fetchMembers(_ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        return WSAPIRequest.getMembers([:], success: success, failure: failure)
    }
}

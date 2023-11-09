//
//  WSRequest+Workspaces.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchNearbyWorkspaces(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getNearbyWorkspaces(parameter, success: success, failure: failure)
    }
}

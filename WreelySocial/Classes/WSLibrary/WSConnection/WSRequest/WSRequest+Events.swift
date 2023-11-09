//
//  WSRequest+Event.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func fetchEvents(_ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getEvents(["page_number": "1", "per_page" : "10"], success: success, failure: failure)
    }
    
    class func eventAttend(_ eventId: String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getAttendEvent(["event_id": eventId], success: success, failure: failure)
    }
    
    class func eventUnAttend(_ eventId: String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getUnAttendEvent(["event_id": eventId], success: success, failure: failure)
    }
}

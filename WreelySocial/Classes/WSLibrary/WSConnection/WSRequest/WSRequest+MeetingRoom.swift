//
//  WSRequest+MeetingRoom.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSRequest {    
    class func fetchMeetinRooms(_ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMeetingRooms([:], success: success, failure: failure)
    }
    
    class func fetchMeetingRoomDashboard(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMeetingRoomDashboard(parameter, success: success, failure: failure)
    }
    
    class func fetchMeetinRoomSlots(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMeetingRoomSlots(parameter, success: success, failure: failure)
    }
    
    class func fetchMeetinRoomHistory(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMeetingRoomHistory(parameter, success: success, failure: failure)
    }
    
    class func cancelMeetingRoomBooking(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMeetingRoomCancel(parameter, success: success, failure: failure)
    }
    
    class func addMeetingRoomBooking(_ parameter: [String : Any], success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.postMeetingRoomBooking(parameter, success: success, failure: failure)
    }
}

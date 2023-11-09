//
//  WSAPIRequest+MeetingRooms.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {

    class func getMeetingRooms(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRooms)
        let urlString = WSAPIStringUrl.getMeetingRoomsEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func getMeetingRoomSlots(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRoomSlots)
        let urlString = WSAPIStringUrl.getMeetingRoomSlotsEndpoint(parameters["room_id"] as! String, start_date: parameters["start_date"] as! String, end_date: parameters["end_date"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func getMeetingRoomHistory(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRoomHistory)
        let urlString = WSAPIStringUrl.getMeetingRoomHistoryEndpoint(parameters["start_date"] as! String, end_date: parameters["end_date"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func getMeetingRoomDashboard(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRoomDashboard)
        let urlString = WSAPIStringUrl.getMeetingRoomDashboardEndpoint(parameters["start_date"] as! String, end_date: parameters["end_date"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    
    class func getMeetingRoomCancel(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRoomCancel)
        let urlString = WSAPIStringUrl.getMeetingRoomCancelEndpoint(parameters["booking_id"] as! String, member_id: parameters["member_id"] as! String)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func postMeetingRoomBooking(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestMeetingRoomBooking)
        let urlString = WSAPIStringUrl.postMeetingRoomBookingEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
}

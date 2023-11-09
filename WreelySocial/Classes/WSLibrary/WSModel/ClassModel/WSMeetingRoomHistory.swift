//
//  WSMeetingRoomHistory.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 26/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMeetingRoomHistory : Mappable {
    var id : Int = 0
    var meetingRoomId : String?
    var meetingRoomName : String?
    var startTime : String?
    var endTime : String?
    var bookedByMemberId : Int = 0
    
    var isBookedByMe : Bool {
        return self.bookedByMemberId == Int((WSSession.activeSession().currentUser().id?.toString())!)
    }
    
    var isCancellable : Bool {
        return (self.startTime?.toServerDate.timeIntervalSinceNow)! > (60 * 60)
    }
    
    init?(map: Map) {
        
    }
        
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        meetingRoomId    <-  map["meeting_room_id"]
        startTime    <-  map["start_time"]
        endTime    <-  map["end_time"]
        meetingRoomName    <-  map["meeting_room_name"]
        bookedByMemberId    <-  map["booked_by_member_id"]
    }

}

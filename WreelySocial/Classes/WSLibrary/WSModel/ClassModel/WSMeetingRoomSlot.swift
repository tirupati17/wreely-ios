//
//  WSMeetingRoomSlot.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMeetingRoomSlot : Mappable {
    var id : Int = 0
    var meetingRoomId : String?
    var startTime : String?
    var endTime : String?
    var isAvailable : Int?
    var isFreeCreditUsed : Int? = 0
    var bookedByMemberId : Int = 0
    
    var availableStatus : Int {
        return (self.startTime?.toServerDate.isPastDate)! ? 0 : (self.isBookedByMe ? (self.isCancellable ? 1 : 0) : self.isAvailable)!
    }
    
    var isBookedByMe : Bool {
        return self.bookedByMemberId == WSSession.activeSession().currentUser().id
    }
    
    var isCancellable : Bool {
        return (self.startTime?.toServerDate.timeIntervalSinceNow)! >= tMinute * 15
    }

    init?(map: Map) {
        
    }
        
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        meetingRoomId    <-  map["meeting_room_id"]
        startTime    <-  map["start_time"]
        endTime    <-  map["end_time"]
        isAvailable    <-  map["is_available"]
        isFreeCreditUsed    <-  map["is_free_credit_used"]
        bookedByMemberId    <-  map["booked_by_member_id"]
    }
    
}

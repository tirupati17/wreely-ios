//
//  WSMeetingRoomDashboard.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/10/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMeetingRoomDashboard : Mappable {
    var bookingSlot : Int? = 0
    var totalBookingCount : Int? = 0
    var month : String? = ""
    var totalUsage : String? = ""
    var freeRemaining : String? = ""
    var freeCredit : String? = ""
    var paidUsage : String? = ""

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        bookingSlot      <-  map["booking_slot"]
        totalBookingCount    <-  map["total_booking_count"]
        month    <-  map["month"]
        totalUsage    <-  map["total_usage"]
        freeRemaining    <-  map["free_remaining"]
        freeCredit    <-  map["free_credit"]
        paidUsage    <-  map["paid_usage"]
    }
    
}

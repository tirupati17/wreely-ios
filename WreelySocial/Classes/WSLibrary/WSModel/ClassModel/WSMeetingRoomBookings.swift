//
//  WSMeetingRoomBookings.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 29/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMeetingRoomBookings : Mappable {
    var id : Int?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
    }
    
}

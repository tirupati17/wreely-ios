//
//  WSMeetingRoom.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 29/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMeetingRoom : Mappable {
    var id : Int = 0
    var name : String? = ""
    var startTime : String? = ""
    var endTime : String? = ""
    var description : String? = ""
    var images : [String]? = []

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        startTime    <-  map["start_time"]
        endTime    <-  map["end_time"]
        description    <-  map["description"]
        images    <-  map["images"]
    }
    
}

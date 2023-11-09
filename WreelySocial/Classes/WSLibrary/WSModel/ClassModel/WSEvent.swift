//
//  WSEvent.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct WSEvent: Mappable {
    var id : Int?
    var title : String?
    var startTime : String?
    var endTime : String?
    var description : String? {
        didSet {
            self.description = NSString(format:"<span style=\"font-family: \(WSConstant.AppCustomFontBold); font-size: \(14)\">%@</span>" as NSString, self.description!) as String
        }
    }
    var vendorId : Int?
    var headerImageUrl : String?
    var totalRsvp : Int? = 0
    var isAttending : Int?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        title    <-  map["title"]
        startTime    <-  map["start_time"]
        endTime    <-  map["end_time"]
        description    <-  map["description"]
        vendorId    <-  map["vendor_id"]
        headerImageUrl    <-  map["header_image_url"]
        totalRsvp    <-  map["total_rsvp"]
        isAttending    <-  map["is_attending"]
    }
}

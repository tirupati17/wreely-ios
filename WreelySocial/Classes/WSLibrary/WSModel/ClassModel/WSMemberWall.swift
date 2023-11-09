//
//  WSMemberWall.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 12/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMemberWall : Mappable {
    var id : Int? = 0
    var name : String? = ""
    var memberId : Int? = 0
    var memberProfileImage : String? = ""
    var statusImage : String? = ""
    var statusImages : [String] = []
    var statusText : String? = ""
    var vendorId : Int? = 0
    var date : String? = ""
    var numberOfLikes : Int? = 0
    var numberOfCommment : Int? = 0
    var isLikedByMe : Bool? = false

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        memberId    <-  map["member_id"]
        memberProfileImage    <-  map["member_profile_image"]
        statusImage    <-  map["status_image"]
        statusImages    <-  map["status_images"]
        statusText    <-  map["status_text"]
        vendorId    <-  map["vendor_id"]
        date    <-  map["date"]
        numberOfLikes    <-  map["number_of_likes"]
        numberOfCommment    <-  map["number_of_commment"]
        isLikedByMe    <-  map["is_liked_by_me"]
    }
    
}

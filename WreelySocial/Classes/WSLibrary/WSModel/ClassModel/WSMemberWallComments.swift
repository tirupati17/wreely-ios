//
//  WSMemberWallComments.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 03/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMemberWallComments : Mappable {
    var id : Int? = 0
    var postId : Int? = 0
    var date : String? = ""
    var comment : String? = ""
    var memberId : Int? = 0
    var memberName : String? = ""
    var memberProfileImage : String? = ""

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        postId    <-  map["post_id"]
        date    <-  map["date"]
        comment    <-  map["comment"]
        memberId    <-  map["member_id"]
        memberName    <-  map["member_name"]
        memberProfileImage    <-  map["member_profile_image"]
    }
    
}

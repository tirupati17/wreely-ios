//
//  WSMemberWallLikes.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 03/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMemberWallLikes : Mappable {
    var id : Int? = 0
    var postId : Int? = 0
    var memberName : String? = ""
    var memberId : Int? = 0
    var memberProfileImage : String? = ""

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        postId    <-  map["post_id"]
        memberId    <-  map["member_id"]
        memberName    <-  map["member_name"]
        memberProfileImage    <-  map["member_profile_image"]
    }
    
}

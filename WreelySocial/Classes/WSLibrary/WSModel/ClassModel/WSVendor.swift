//
//  WSVendor.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 16/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSVendor : Mappable {
    var id : Int? = 0
    var name : String? = ""
    var vendorLogoUrl : String? = ""
    var emailId : String? = ""
    var totalMember : Int? = 0

    init?(map: Map) {
        
    }
        
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        emailId    <-  map["email_id"]
        vendorLogoUrl    <-  map["vendor_logo_url"]
        totalMember    <-  map["total_member"]
    }
}

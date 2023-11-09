//
//  WSCompany.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 29/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSCompany : Mappable {
    var id : Int?
    var name : String? = ""
    var userId : String? = ""
    var contactMemberId : Int?
    var contactPersonEmailId : String? = ""
    var contactPersonName : String? = ""
    var contactPersonNumber : String? = ""
    var status : Int?
    var website : String? = ""
    var aboutCompany : String? = ""
    var isDeleted : Int?
    var companyLogoURL : String? = ""

    init?(map: Map) {
        
    }
        
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        userId    <-  map["user_id"]
        contactMemberId    <-  map["contact_member_id"]
        contactPersonEmailId    <-  map["contact_person_email_id"]
        contactPersonName    <-  map["contact_person_name"]
        contactPersonNumber    <-  map["contact_person_number"]
        status    <-  map["status"]
        website    <-  map["website"]
        aboutCompany    <-  map["about"]
        isDeleted    <-  map["isDeleted"]
        companyLogoURL    <-  map["company_logo_url"]
    }
    
}

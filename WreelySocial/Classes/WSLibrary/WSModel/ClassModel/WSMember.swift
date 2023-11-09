//
//  WSMember.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 29/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSMember : Mappable {
    var id : Int? = 0
    var name : String? = ""
    var contactNo : String? = ""
    var emailId : String? = ""
    var occupation : String? = ""
    var membershipTypeId : String? = ""
    var aboutMe : String? = ""
    var profilePicUrl : String? = ""
    var companyId : String? = ""
    var companyName : String? = ""
    var websiteUrl : String? = ""
    var twitterUrl : String? = ""
    var linkedinUrl : String? = ""
    var instagramUrl : String? = ""
    var facebookUrl : String? = ""
    var memberFirKey : String? = ""
    var createdDtm : Date? = Date.init()

    init?(map: Map) {
        
    }
    
    init(id: Int, name: String, profilePicUrl: String? = "") {
        self.id = id
        self.name = name
        self.profilePicUrl = profilePicUrl
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        contactNo    <-  map["contact_no"]
        emailId    <-  map["email_id"]
        occupation    <-  map["occupation"]
        membershipTypeId    <-  map["membership_type_id"]
        aboutMe    <-  map["about_me"]
        profilePicUrl    <-  map["profile_pic_url"]
        companyId    <-  map["company_id"]
        companyName    <-  map["company_name"]
        websiteUrl    <-  map["website_url"]
        twitterUrl    <-  map["twitter_url"]
        linkedinUrl    <-  map["linkedin_url"]
        instagramUrl    <-  map["instagram_url"]
        facebookUrl    <-  map["facebook_url"]
        createdDtm    <-  map["created_dtm"]
        memberFirKey    <-  map["member_fir_key"]
    }
}

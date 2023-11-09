//
//  WSFIRVendor.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 08/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Firebase

class WSFIRVendor {
    var vendorID = ""
    var firebaseId : String? = ""
    var name = ""
    var logoUrl : URL!
    var email = ""
    var mobile = ""
    var accessToken = ""
    var domainNameReference = ""
    var vendorSqlId = ""
    var members : [String]!
    var companies : [String]!
    
    init(snapshot : DataSnapshot) {
        guard let value = snapshot.value as? [String : Any] else {
            return
        }
        self.vendorID = snapshot.key
        self.firebaseId = snapshot.key
        if let name = value["name"]! as? String {
            self.name = name
        }
        if value["email"] != nil {
            self.email = (value["email"]! as? String)!
        }
        
        if value["mobile"] != nil {
            self.mobile = (value["mobile"]! as? String)!
        }

        if let accessToken = value["access_token"]! as? String {
            self.accessToken = accessToken
        }
        if let domainNameReference = value["domain_name_reference"] as? String {
            self.domainNameReference = domainNameReference
        }
        if let vendorSqlId = value["id"]! as? String {
            self.vendorSqlId = vendorSqlId
        }
        self.logoUrl = (value["vendor_logo_url"] as? String).flatMap(URL.init)
        guard let members = value["members"] as? [String] else {
            return
        }
        self.members = members

        guard let companies = value["companies"] as? [String] else {
            return
        }
        self.companies = companies
    }
}

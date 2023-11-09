//
//  WSFIRCompany.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 08/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Firebase
import Foundation

class WSFIRCompany {
    var companyID = ""
    var name = ""
    var website : URL!
    var vendorKey = ""
    var companyDetail = ""
    var contactPersonName = ""
    var contactPersonEmail = ""
    var contactPersonNumber = ""
    var companyLogoURL : URL!
    var companySqlId = ""
    var members : [String]!
    
    init (snapshot : DataSnapshot) {
        guard let value = snapshot.value as? [String:Any] else {
            return
        }
        self.companyID = snapshot.key
        if let name = value["name"] as? String {
            self.name = name
        }
        self.website = (value["website"] as? String).flatMap(URL.init)
        if let vendorKey = value["vendor_key"] as? String {
            self.vendorKey = vendorKey
        }
        if let companyDetail = value["company_detail"] as? String {
            self.companyDetail = companyDetail
        }
        if let contactPersonName = value["contact_person_name"] as? String {
            self.contactPersonName = contactPersonName
        }
        if let contactPersonEmail = value["contact_person_email"] as? String {
            self.vendorKey = contactPersonEmail
        }
        if let contactPersonNumber = value["contact_person_number"] as? String {
            self.vendorKey = contactPersonNumber
        }
        if let companySqlId = value["id"] as? String {
            self.companySqlId = companySqlId
        }
        if (value["company_logo_url"] as? String) != nil {
            self.companyLogoURL = (value["company_logo_url"] as? String).flatMap(URL.init)
        }
        guard let members = value["members"] as? [String] else {
            return
        }
        self.members = members
    }
}

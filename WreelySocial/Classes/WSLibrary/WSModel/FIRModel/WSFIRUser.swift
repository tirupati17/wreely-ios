//
//  WSFIRUser.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 08/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Firebase
import Foundation

class WSFIRUser {
    var userID = ""
    var firebaseId : String? = ""
    var name = ""
    var email = ""
    var mobile = ""
    var aboutMe = ""
    var profileLink = ""
    var vendors : [String]!
    var companyKey = ""
    var occupation = ""
    var userSqlId = ""
    var vendorId = ""
    var profilePicUrl : URL!
    
    init(snapshot : DataSnapshot? = nil) {
        guard let value = snapshot?.value as? [String : Any] else {
            return
        }
        self.userID = (snapshot?.key)!
        self.firebaseId = (snapshot?.key)!

        if let name = value["full_name"] as? String {
            self.name = name
        }
        if let email = value["email"] as? String {
            self.email = email
        }
        if let mobile = value["mobile"] as? String {
            self.mobile = mobile
        }
        if let aboutMe = value["about_me"] as? String {
            self.aboutMe = aboutMe
        }
        if let profileLink = value["profile_link"] as? String {
            self.profileLink = profileLink
        }
        if let companyKey = value["company_key"] as? String {
            self.companyKey = companyKey
        }
        if let vendorId = value["vendor_id"] as? String {
            self.vendorId = vendorId
        }
        if let occupation = value["occupation"] as? String {
            self.occupation = occupation
        }
        if let userSqlId = value["id"] as? String {
            self.userSqlId = userSqlId
        }
        if let profilePicUrl = (value["profile_pic_url"] as? String).flatMap(URL.init) {
            self.profilePicUrl = profilePicUrl
        }
//        if let vendors = value["vendors"]! as? [String] {
//            self.vendors = vendors
//        }
    }
    
    init(dictionary: [String: String]) {
        guard let uid = dictionary["uid"] else {
            return
        }
        self.userID = uid
        self.firebaseId = uid
        guard let fullname = dictionary["full_name"] else {
            return
        }
        self.name = fullname
        
        guard let profilePicture = dictionary["profile_pic_url"],
        let profilePicURL = URL(string: profilePicture) else {
                return
        }
        self.profilePicUrl = profilePicURL
    }
    
    init(user: User) {
        self.userID = user.uid
        self.firebaseId = user.uid
        self.name = user.displayName ?? ""
        self.profilePicUrl = user.photoURL
    }
    
    static func currentUser() -> WSFIRUser {
        return WSFIRUser(user: Auth.auth().currentUser!)
    }
}

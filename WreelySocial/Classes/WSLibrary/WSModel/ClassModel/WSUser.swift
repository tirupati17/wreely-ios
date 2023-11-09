//
//  WSUser.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 12/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct WSUser: Mappable {
    var id : Int?
    var name : String?
    var mobile : String?
    var email : String?
    var accessToken : String?
    var password : String?
    var createdDtm : Date? = Date.init()
    
    init?(map: Map) {
        
    }
        
    func returnFirebaseCompatibleDictionary() -> [String : AnyObject] {
        return ["accessToken": self.accessToken as AnyObject,
                "email": self.email as AnyObject,
                "id": self.id as AnyObject,
                "mobile": self.mobile as AnyObject,
                "name": self.name as AnyObject,
                "createdDtm": self.createdDtm as AnyObject,
                "lastLoginAt": Date.init().getCurrentDateString as AnyObject,
                "device": UIDevice.init().modelName as AnyObject]
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        mobile    <-  map["mobile"]
        email    <-  map["email"]
        accessToken    <-  map["access_token"]
        password    <-  map["password"]
        createdDtm    <-  map["createdDtm"]
    }
    
}

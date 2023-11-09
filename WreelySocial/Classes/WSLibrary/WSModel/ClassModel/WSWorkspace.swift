//
//  WSWorkspace.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ObjectMapper

struct WSWorkspace : Mappable {
    var csId : String = ""
    var name : String = ""
    var address : String = ""
    var postalArea : String = ""
    var city : String = ""
    var state : String = ""
    var country : String  = ""
    var latitude : String = ""
    var longitude : String  = ""
    var image : String = ""
    var cwUrl : String = ""
    var currency : String = ""
    var dayPrice : String  = ""
    var weekPrice : String = ""
    var monthPrice : String  = ""
    var description : String  = ""
    var starRating : String = ""
    var numReviews : String = ""
    var maxCapacity : String = ""
    var privateRooms : String = ""
    var meetingRooms : String = ""
    var isFirebaseEnabled : Bool = false
    var additionalImages : String = ""
    
    init?(map: Map) {
        
    }
    
    var workspaceUrl : URL {
        return URL.init(string: self.cwUrl)!
    }
    
    var imageUrl : URL {
        return URL.init(string: self.image)!
    }
    
    var additionalImageArray : [String] {
        return self.additionalImages.components(separatedBy: CharacterSet.init(charactersIn: ","))
    }
    
    mutating func mapping(map: Map) {
        csId <- map["cs_id"]
        name <- map["NAME"]
        address <- map["address"]
        postalArea <- map["postal_area"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        image <- map["image"]
        cwUrl <- map["cw_url"]
        currency <- map["currency"]
        dayPrice <- map["day_price"]
        weekPrice <- map["week_price"]
        monthPrice <- map["month_price"]
        description <- map["description"]
        starRating <- map["star_rating"]
        numReviews <- map["num_reviews"]
        maxCapacity <- map["max_capacity"]
        privateRooms <- map["private_rooms"]
        meetingRooms <- map["meeting_rooms"]
        additionalImages <- map["additional_images"]
    }
    
}

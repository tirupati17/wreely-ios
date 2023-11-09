//
//  WSFIREvent.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase

class WSFIREvent {
    var eventID = ""
    var name = ""
    var description = ""
    var photos : [String]!
    var eventDate = Date()
    var startTime = Date()
    var endTime = Date()

    init (snapshot : DataSnapshot) {
        guard let value = snapshot.value as? [String:Any] else {
            return
        }
        self.eventID = snapshot.key
        if let name = value["name"] as? String {
            self.name = name
        }
        if let description = value["description"] as? String {
            self.description = description
        }
        if let eventDate = value["event_date"] as? String {
            self.eventDate = Date.init()
        }
        if let startTime = value["start_time"] as? String {
            self.startTime = Date.init()
        }
        if let endTime = value["end_time"] as? String {
            self.endTime = Date.init()
        }
        if let photos = value["photos"]! as? [String] {
            self.photos = photos
        }
    }
}

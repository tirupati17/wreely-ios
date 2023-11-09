//
//  WSMeetingRoomSlotsCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSMeetingRoomSlotsCellUIControlTag : Int {
    case nameLabel = 111
    case selectionButton = 112
    case unknownType
}

class WSMeetingRoomSlotsCell : WSTableViewCell {
    override func awakeFromNib() {
        print("Hello")
    }
}

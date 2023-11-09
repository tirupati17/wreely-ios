//
//  WSMeetingRoomListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material

enum WSMeetingRoomListCellUIControlTag : Int {
    case nameLabel = 111
    case availabilityLabel = 112
    case thumbImageView = 113
    case unknownType
}

class WSMeetingRoomListCell : WSTableViewCell {    
    override func awakeFromNib() {
        print("Hello")
    }
}


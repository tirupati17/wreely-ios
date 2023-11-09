//
//  WSStoryboard+Protocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier : String { get }
}

extension StoryboardIdentifiable where Self : UIViewController {
    static var storyboardIdentifier : String {
        return String(describing : self)
    }
}

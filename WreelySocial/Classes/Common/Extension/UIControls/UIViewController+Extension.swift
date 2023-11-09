//
//  UIViewController+Extension.swift
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

extension WSViewController : StoryboardIdentifiable {
    
}

extension WSViewController {
    func presentWithAnimated(_ vc : UIViewController) {
        self.present(vc, animated: true) {
            
        }
    }
}

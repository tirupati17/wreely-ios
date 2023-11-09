//
//  WSTableViewCell+Protocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSCellProtocol {
    func didChangeValue<T>(forCell tableViewCell : UITableViewCell, atIndex indexPath : NSIndexPath, atValue value : T)
}

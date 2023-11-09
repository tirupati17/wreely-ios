//
//  WSMemberWallPostProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSMemberWallPostViewProtocol : UIViewControllerProtocol {
    func didSuccessfulResponse<T>(_ response: T)
}

protocol WSMemberWallPostPresenterProtocol {
    func submitPost(memberWallPostViewItem : WSMemberWallPostViewItem)
}

//
//  WSMemberWallProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSMemberWallViewProtocol : UIViewControllerProtocol {
    func updateWallPost(_ wallPosts : [WSMemberWall])
    func updateLikeStatus()
}

protocol WSMemberWallPresenterProtocol {
    func didDeleteWallPost(wallPost : WSMemberWall)
    func didSelectWallPost(wallPost : WSMemberWall)
    func didUpdateLike(forPost : WSMemberWall)
    func didFetchWallFeeds()
}

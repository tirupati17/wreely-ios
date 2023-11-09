//
//  WSMemberWallLikeProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSMemberWallLikeViewProtocol : UIViewControllerProtocol {
    func didSuccessfulResponse<T>(_ response: T)
}

protocol WSMemberWallLikePresenterProtocol {
    func fetchLikes(forPost : WSMemberWall)
}

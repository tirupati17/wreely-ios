//
//  WSMemberWallCommentProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSMemberWallCommentViewProtocol : UIViewControllerProtocol {
    func updateCommentList(_ response: [WSMemberWallComments])
    func didSuccessfulResponse<T>(_ response: T)
}

protocol WSMemberWallCommentPresenterProtocol {
    func didFetchComment(forPost : WSMemberWall)
    func didSendComment(data : [String : Any])
    func didDeleteComment(comment : WSMemberWallComments)
}

//
//  WSWorkspaceListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSWorkspaceListViewProtocol : UIViewControllerProtocol {
    func updateWorkspace(_ workspaces : [WSWorkspace])
    func updateLocation(_ lat : String, lon : String)
}

protocol WSWorkspaceListPresenterProtocol {
    func didSelectWorkspace(workspace : WSWorkspace)
    func didFetchWorkspaces(_ lat : String, lon : String, rad : String)
    func didFetchCurrentLocation()
}

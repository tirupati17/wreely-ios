//
//  WSWorkspaceSelectionProtocols.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSWorkspaceSelectionViewProtocol {
    func didFailedResponse<T>(_ error : T)
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateVendors(_ vendors : [WSVendor])
}

protocol WSWorkspaceSelectionPresenterProtocol {
    func didSelectWorkspace(vendor : WSVendor)
    func didFetchVendors()
}

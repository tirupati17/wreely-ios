//
//  WSWorkspaceListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftLocation

class WSWorkspaceListPresenter {
    var workspaceListViewProtocol : WSWorkspaceListViewProtocol!
}

extension WSWorkspaceListPresenter : WSWorkspaceListPresenterProtocol {
    func didSelectWorkspace(workspace: WSWorkspace) {

    }
    
    func didFetchWorkspaces(_ lat : String, lon : String, rad : String) {
        WSRequest.fetchNearbyWorkspaces(["lat":lat, "lon":lon, "rad":rad], success: { (response) in
            self.workspaceListViewProtocol.updateWorkspace(response as! [WSWorkspace])
        }) { (error) in
            self.workspaceListViewProtocol.didFailedResponse(error)
        }
    }
    
    func didFetchCurrentLocation() {
        Locator.currentPosition(accuracy: .city, onSuccess: { (location) -> (Void) in
            self.workspaceListViewProtocol.updateLocation("\(location.coordinate.latitude)", lon: "\(location.coordinate.longitude)")
        }) { (err, last) -> (Void) in
            print("Failed to get location: \(err)")
            self.workspaceListViewProtocol.updateLocation("\(last?.coordinate.latitude ?? 19.1726)", lon: "\(last?.coordinate.longitude ?? 72.9425)")
        }
    }
}

//
//  WSEventListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSEventListPresenter  {
    var eventListViewProtocol : WSEventListViewProtocol!
    
}

extension WSEventListPresenter : WSEventListPresenterProtocol {
    func didSelectEvent(event : WSEvent?) {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSEventDetailView.storyboardIdentifier) as! WSEventDetailView
        vc.event = event
        self.eventListViewProtocol.pushController(vc)
    }
    
    func attendEvent(_ eventId : String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSRequest.eventAttend(eventId, success: success, failure: failure)
    }

    func unAttendEvent(_ eventId : String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSRequest.eventUnAttend(eventId, success: success, failure: failure)
    }
    
    func didFetchEvents() {
        WSRequest.fetchEvents({ (events) in
            self.eventListViewProtocol.updateView(events as! [WSEvent])
        }) { (error) in
            self.eventListViewProtocol.didFailedResponse(error)
        }
    }
}

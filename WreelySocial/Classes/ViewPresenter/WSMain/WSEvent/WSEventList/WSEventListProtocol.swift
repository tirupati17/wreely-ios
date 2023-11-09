//
//  WSEventListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol WSEventListViewProtocol : UIViewControllerProtocol {
    func updateView(_ events : [WSEvent])
}

protocol WSEventListPresenterProtocol {
    func didSelectEvent(event : WSEvent?)
    func didFetchEvents()
    func attendEvent(_ eventId : String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!)
    func unAttendEvent(_ eventId : String, success:((AnyObject) -> Void)!, failure:((Error) -> Void)!)
}

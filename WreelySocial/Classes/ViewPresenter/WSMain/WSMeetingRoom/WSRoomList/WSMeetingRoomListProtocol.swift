//
//  WSMeetingRoomListProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 28/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSMeetingRoomListViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateMeetingRooms(_ meetingRooms : [WSMeetingRoom])
    func updateDashboard(dashboard : WSMeetingRoomDashboard!)
}

protocol WSMeetingRoomListPresenterProtocol {
    func didFetchMeetingRoomDashboard()
    func didSelectMeetingRoom(meetingRoom : WSMeetingRoom)
    func didFetchMeetingRooms()
    func showHistory()
}

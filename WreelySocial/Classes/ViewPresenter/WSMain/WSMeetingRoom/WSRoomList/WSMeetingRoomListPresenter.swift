//
//  WSMeetingRoomListPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 28/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMeetingRoomListPresenter {
    var meetingRoomListViewProtocol : WSMeetingRoomListViewProtocol!
}

extension WSMeetingRoomListPresenter : WSMeetingRoomListPresenterProtocol {
    func didFetchMeetingRooms() {
        WSRequest.fetchMeetinRooms({ (object) in
            self.meetingRoomListViewProtocol.updateMeetingRooms(object as! [WSMeetingRoom])
        }, failure: { (error) in
            self.meetingRoomListViewProtocol.updateMeetingRooms([])
        })
    }
    
    func didFetchMeetingRoomDashboard() {
        WSRequest.fetchMeetingRoomDashboard(["start_date" : Date.init().getStartOf(.kMonth).toServerDateString, "end_date" : Date.init().getEndOf(.kMonth).toServerDateString], success: { (object) in
            self.meetingRoomListViewProtocol.updateDashboard(dashboard: object as! WSMeetingRoomDashboard)
        }, failure: { (error) in
            self.meetingRoomListViewProtocol.updateDashboard(dashboard: nil)
        })
    }
    
    func didSelectMeetingRoom(meetingRoom : WSMeetingRoom) {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: "WSMeetingRoomSlotsView") as! WSMeetingRoomSlotsView
        vc.selectedMeetingRoom = meetingRoom
        self.meetingRoomListViewProtocol.pushController(vc)
    }
    
    func showHistory() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMeetingRoomHistoryView.storyboardIdentifier)
        self.meetingRoomListViewProtocol.pushController(vc)
    }
}

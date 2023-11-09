//
//  WSMeetingRoomSlotsProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSMeetingRoomSlotsViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateMeetingRoomSlots(_ meetingRoomSlots : [WSMeetingRoomSlot])
    func didCancelSuccessfull()
    func didBookingSuccessfull()
    func didFailedResponse(_ error : Error)
    func didCancelFailedResponse(_ error : Error)
}

protocol WSMeetingRoomSlotsPresenterProtocol {
    func didSelectMeetingRoomSlot(meetingRoomSlot : WSMeetingRoomSlot)
    func didFetchMeetingRoomSlots(_ roomId : String, startDate : String, endDate : String)
}


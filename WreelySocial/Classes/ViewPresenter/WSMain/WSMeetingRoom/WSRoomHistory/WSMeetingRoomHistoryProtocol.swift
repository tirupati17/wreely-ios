//
//  WSMeetingRoomHistoryProtocol.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 26/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

protocol WSMeetingRoomHistoryViewProtocol {
    func presentController<T>(_ vc: T)
    func pushController<T>(_ vc: T)
    func updateMeetingRoomHistory(_ meetingRoomHistory : [WSMeetingRoomHistory])
    func didCancelSuccessful()
    func didFailedResponse(_ error : Error)
}

protocol WSMeetingRoomHistoryPresenterProtocol {
    func didSelectMeetingRoomHistory(meetingRoomHistory : WSMeetingRoomHistory)
    func didFetchMeetingRoomHistory(_ memberId : String, startDate : String, endDate : String)
}


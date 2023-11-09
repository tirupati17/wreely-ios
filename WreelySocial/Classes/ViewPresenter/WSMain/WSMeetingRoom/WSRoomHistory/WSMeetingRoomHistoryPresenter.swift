//
//  WSMeetingRoomHistoryPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 26/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMeetingRoomHistoryPresenter {
    var meetingRoomHistoryViewProtocol : WSMeetingRoomHistoryViewProtocol!
}

extension WSMeetingRoomHistoryPresenter : WSMeetingRoomHistoryPresenterProtocol {
    
    func didSelectMeetingRoomHistory(meetingRoomHistory: WSMeetingRoomHistory) {
        if meetingRoomHistory.isBookedByMe {
            WSRequest.cancelMeetingRoomBooking(["booking_id" : "\(meetingRoomHistory.id)", "member_id" : "\(meetingRoomHistory.bookedByMemberId)"], success: { (object) in
                self.meetingRoomHistoryViewProtocol.didCancelSuccessful()
            }, failure: { (error) in
                self.meetingRoomHistoryViewProtocol.didFailedResponse(error)
            })
        }
    }
    
    func didFetchMeetingRoomHistory(_ memberId : String, startDate : String, endDate : String) {
        WSRequest.fetchMeetinRoomHistory(["member_id" : memberId, "start_date" : startDate, "end_date" : endDate], success: { (object) in
            self.meetingRoomHistoryViewProtocol.updateMeetingRoomHistory(object as! [WSMeetingRoomHistory])
        }) { (error) in
            self.meetingRoomHistoryViewProtocol.didFailedResponse(error)
        }
    }
}

//
//  WSMeetingRoomSlotsPresenter.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMeetingRoomSlotsPresenter {
    var meetingRoomSlotsViewProtocol : WSMeetingRoomSlotsViewProtocol!
}

extension WSMeetingRoomSlotsPresenter : WSMeetingRoomSlotsPresenterProtocol {
    func didFetchMeetingRoomSlots(_ roomId : String, startDate : String, endDate : String) {
        WSRequest.fetchMeetinRoomSlots(["room_id" : roomId, "start_date" : startDate, "end_date" : endDate], success: { (object) in
            self.meetingRoomSlotsViewProtocol.updateMeetingRoomSlots(object as! [WSMeetingRoomSlot])
        }) { (error) in
            self.meetingRoomSlotsViewProtocol.updateMeetingRoomSlots([])
        }
    }
    
    func didSelectMeetingRoomSlot(meetingRoomSlot : WSMeetingRoomSlot) {
        if meetingRoomSlot.isBookedByMe {
            WSRequest.cancelMeetingRoomBooking(["booking_id" : "\(meetingRoomSlot.id)", "member_id" : "\(meetingRoomSlot.bookedByMemberId)"], success: { (object) in
                self.meetingRoomSlotsViewProtocol.didCancelSuccessfull()
            }, failure: { (error) in
                self.meetingRoomSlotsViewProtocol.didCancelFailedResponse(error)
            })
        } else {
            WSRequest.addMeetingRoomBooking(["room_id" : meetingRoomSlot.meetingRoomId ?? "0", "start_time" : meetingRoomSlot.startTime ?? "", "end_time" : meetingRoomSlot.endTime ?? "", "member_id" : "\(WSSession.activeSession().currentUser().id!)"], success: { (object) in
                self.meetingRoomSlotsViewProtocol.didBookingSuccessfull()
            }, failure: { (error) in
                self.meetingRoomSlotsViewProtocol.didFailedResponse(error)
            })
        }
    }
}

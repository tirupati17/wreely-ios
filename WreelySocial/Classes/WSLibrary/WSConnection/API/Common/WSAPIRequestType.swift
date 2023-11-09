//
//  WSAPIRequestType.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation

enum WSAPIRequestType: Int {
    case APIRequestLogin = 1
    case APIRequestSignUp = 2
    case APIRequestForgotPasswordEmail = 3
    case APIRequestRandomCode = 4
    case APIRequestUpdateDeviceToken = 5
    case APIRequestUpdateUser = 6
    case APIRequestGetUser = 7
    case APIRequestForgotPasswordChange = 8
    case APIRequestUserProfileUpdate = 9
    case APIRequestMembers = 10
    case APIRequestCompanies = 11
    case APIRequestMemberWallFeeds = 12
    case APIRequestMemberWallFeedCommentList = 13
    case APIRequestMemberWallFeedLikeList = 14
    case APIRequestCreateMemberWallPost = 15
    case APIRequestCreateMemberWallFeedComment = 16
    case APIRequestCreateMemberWallFeedLike = 17
    case APIRequestDeleteMemberWallPost = 18
    case APIRequestDeleteMemberWallFeedComment = 19
    case APIRequestDeleteMemberWallFeedLike = 20
    case APIRequestMeetingRooms = 21
    case APIRequestMeetingRoomSlots = 22
    case APIRequestMeetingRoomHistory = 23
    case APIRequestMeetingRoomBooking = 24
    case APIRequestMeetingRoomCancel = 25
    case APIRequestOTPLogin = 26
    case APIRequestOTPConfirmation = 27
    case APIRequestVendors = 28
    case APIRequestEvents = 29
    case APIRequestEventAttend = 30
    case APIRequestEventUnAttend = 31
    case APIRequestGetCurrentMember = 32
    case APIRequestUpdateCurrentMember = 33
    case APIRequestNearByWorkspaces = 34
    case APIRequestUpdateMemberFirebaseKey = 35
    case APIRequestMemberFollow = 36
    case APIRequestMemberUnFollow = 37
    case APIRequestMeetingRoomDashboard = 38
    case APIRequestUndefined = 100
}


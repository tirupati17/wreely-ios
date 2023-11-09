//
//  WSAPIStringUrl.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation

enum WSRequestMethod : Int {
    case RequestMethodGet = 1
    case RequestMethodPost = 2
    case RequestMethodPut = 3
    case RequestMethodDelete = 4
}

class WSAPIStringUrl {
    static let kLoginEndpoint = "user/login"
    static let kSignUpEndpoint = "user/registration"
    static let kForgotPasswordEmailEndpoint = "user/forgotpass/email"
    static let kRandomCodeEndpoint = "user/randomcode/confirmation"
    static let kUpdateDeviceEndpoint = "user/devicetoken"
    static let kUpdateUserEndpoint = "user/update"
    static let kForgotPasswordChangeEndpoint = "user/forgotpass/change"
    
    static let kGetOTPLoginEndpoint = "member/login"
    static let kGetOTPConfirmationEndpoint = "member/login/confirmation"
    static let kGetMemberEndpoint = "member"
    static let kUpdateMemberEndpoint = "member/update"
    static let kGetVendorEndpoint = "vendors"
    static let kMeetingRoomsEndpoint = "meetingrooms"
    static let kMeetingRoomSlotsEndpoint = "meetingroom/bookings/room_id=%@&start_date=%@&end_date=%@"
    static let kMeetingRoomHistoryEndpoint = "meetingroom/bookings/history/start_date=%@&end_date=%@"
    static let kMeetingRoomDashboardEndpoint = "meetingroom/dashboard"
    static let kMeetingRoomBookingEndpoint = "meetingroom/bookings"
    static let kMeetingRoomCancelEndpoint = "meetingroom/bookings/cancel/booking_id=%@&member_id=%@"
    static let kGetMembersEndpoint = "members"
    static let kGetCompaniesEndpoint = "companies"
    static let kGetEventsEndpoint = "events/per_page=%@&page_number=%@"
    static let kGetEventAttendEndpoint = "events/attend/event_id=%@"
    static let kGetEventUnAttendEndpoint = "events/unattend/event_id=%@"
    static let kGetNearbyWorkspacesEndpoint = "workspaces/nearby/lat=%@&lon=%@&rad=%@"

    static let kGetMemberWallFeedsEndpoint = "memberwalls/per_page=%@&page_number=%@&is_member_feeds=%@"
    static let kGetMemberWallFeedCommentListEndpoint = "memberwalls/comments/post_id=%@&per_page=%@&page_number=%@"
    static let kGetMemberWallFeedLikeListEndpoint = "memberwalls/likes/post_id=%@&per_page=%@&page_number=%@"
    static let kDeleteMemberWallPostEndpoint = "memberwalls/delete/post_id=%@&post_by_member_id=%@"
    static let kDeleteMemberWallFeedCommentEndpoint = "memberwalls/comments/delete/comment_id=%@"
    static let kDeleteMemberWallFeedLikeEndpoint = "memberwalls/likes/delete/like_id=%@"
    static let kCreateMemberWallPostEndpoint = "memberwalls"
    static let kCreateMemberWallFeedCommentEndpoint = "memberwalls/comments"
    static let kCreateMemberWallFeedLikeEndpoint = "memberwalls/likes"
    static let kUpdateMemberFirebaseKeyEndpoint = "member/update/firebase/firebase_key=%@"
    static let kGetMemberFollowEndpoint = "member/follow/%@"
    static let kGetMemberUnFollowEndpoint = "member/unfollow/%@"

    static func otpLoginEndpoint() -> String {
        return kGetOTPLoginEndpoint
    }

    static func otpConfirmationEndpoint() -> String {
        return kGetOTPConfirmationEndpoint
    }

    static func getVendorsEndpoint() -> String {
        return kGetVendorEndpoint
    }

    static func loginEndpoint() -> String {
        return kLoginEndpoint
    }
    
    static func signUpEndpoint() -> String {
        return kSignUpEndpoint
    }
    
    static func forgotPasswordEmailEndpoint() -> String {
        return kForgotPasswordEmailEndpoint
    }
    
    static func randomCodeEndpoint() -> String {
        return kRandomCodeEndpoint
    }
    
    static func updateDeviceEndpoint() -> String {
        return kUpdateDeviceEndpoint
    }
    
    static func updateUserEndpoint() -> String {
        return kUpdateUserEndpoint
    }
    
    static func updateMemberFirebaseKeyEndpoint(_ firebaseKey : String) -> String {
        return String.init(format: kUpdateMemberFirebaseKeyEndpoint, firebaseKey)
    }
    
    static func getMemberEndpoint() -> String {
        return kGetMemberEndpoint
    }
    
    static func updateMemberEndpoint() -> String {
        return kUpdateMemberEndpoint
    }

    static func forgotPasswordChangeEndpoint() -> String {
        return kForgotPasswordChangeEndpoint
    }
    
    static func getMeetingRoomsEndpoint() -> String {
        return kMeetingRoomsEndpoint
    }

    static func postMeetingRoomBookingEndpoint() -> String {
        return kMeetingRoomBookingEndpoint
    }

    static func getMeetingRoomSlotsEndpoint(_ room_id : String, start_date : String, end_date : String) -> String {
        return String.init(format: kMeetingRoomSlotsEndpoint, room_id, start_date, end_date)
    }
    
    static func getMeetingRoomHistoryEndpoint(_ start_date : String, end_date : String) -> String {
        return String.init(format: kMeetingRoomHistoryEndpoint, start_date, end_date)
    }

    static func getMeetingRoomDashboardEndpoint(_ start_date : String, end_date : String) -> String {
        return String.init(format: kMeetingRoomDashboardEndpoint)
    }

    static func getMeetingRoomCancelEndpoint(_ booking_id : String, member_id : String) -> String {
        return String.init(format: kMeetingRoomCancelEndpoint, booking_id, member_id)
    }
    
    static func getMembersEndpoint() -> String {
        return kGetMembersEndpoint
    }
    
    static func getCompaniesEndpoint() -> String {
        return kGetCompaniesEndpoint
    }

    static func getEventsEndpoint(_ per_page : String, page_number : String) -> String {
        return String.init(format: kGetEventsEndpoint, per_page, page_number)
    }

    static func getEventAttend(_ event_id : String) -> String {
        return String.init(format: kGetEventAttendEndpoint, event_id)
    }

    static func getEventUnAttend(_ event_id : String) -> String {
        return String.init(format: kGetEventUnAttendEndpoint, event_id)
    }
    
    static func getNearByWorkspaces(_ lat : String, lon : String, rad : String) -> String {
        return String.init(format: kGetNearbyWorkspacesEndpoint, lat, lon, rad)
    }
    
    static func getMemberWallFeedsEndpoint(_ per_page : String, page_number : String, is_member_feeds : Bool) -> String {
        return String.init(format: kGetMemberWallFeedsEndpoint, per_page, page_number, is_member_feeds)
    }

    static func getMemberWallFeedCommentListEndpoint(_ post_id : String, per_page : String, page_number : String) -> String {
        return String.init(format: kGetMemberWallFeedCommentListEndpoint, post_id, per_page, page_number)
    }

    static func getMemberWallFeedLikeListEndpoint(_ post_id : String, per_page : String, page_number : String) -> String {
        return String.init(format: kGetMemberWallFeedLikeListEndpoint, post_id, per_page, page_number)
    }
    
    static func deleteMemberWallPostEndpoint(_ post_id : String, post_by_member_id : String) -> String {
        return String.init(format: kDeleteMemberWallPostEndpoint, post_id, post_by_member_id)
    }
    
    static func deleteMemberWallFeedCommentEndpoint(_ comment_id : String) -> String {
        return String.init(format: kDeleteMemberWallFeedCommentEndpoint, comment_id)
    }
    
    static func deleteMemberWallFeedLikeEndpoint(_ like_id : String) -> String {
        return String.init(format: kDeleteMemberWallFeedLikeEndpoint, like_id)
    }
    
    static func createMemberWallPostEndpoint() -> String {
        return kCreateMemberWallPostEndpoint
    }

    static func createMemberWallFeedCommentEndpoint() -> String {
        return kCreateMemberWallFeedCommentEndpoint
    }

    static func createMemberWallFeedLikeEndpoint() -> String {
        return kCreateMemberWallFeedLikeEndpoint
    }

    static func getMemberFollowEndpoint(_ member_id : String) -> String {
        return String.init(format: kGetMemberFollowEndpoint, member_id)
    }
    
    static func getMemberUnFollowEndpoint(_ member_id : String) -> String {
        return String.init(format: kGetMemberUnFollowEndpoint, member_id)
    }
    
    static func getUrlStringForRequestType(_ apiRequestType : WSAPIRequestType) -> String {
        switch apiRequestType {
            case WSAPIRequestType.APIRequestLogin:
                return self.loginEndpoint()
            default:
                return ""
        }
    }
}


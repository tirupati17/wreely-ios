//
//  WSConnectionManager.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import Reachability
//import NotificationBannerSwift

class WSConnectionManager {
    var successBlock : ((JSON) -> Void)! //not in use - use of this calling successBlock of another endpoint which become bug
    var failedBlock : ((Error) -> Void)! //not in use
    let reachability = Reachability()!

    class var sharedInstance : WSConnectionManager {
        struct Singleton {
            static let instance = WSConnectionManager()
        }
        
        return Singleton.instance
    }
    
    func shouldReadResponseForRequest(_ apiRequest : WSAPIRequest) -> Bool  {
        switch apiRequest.requestType {
        case WSAPIRequestType.APIRequestLogin?:
            return true
        case WSAPIRequestType.APIRequestSignUp?:
            return true
        default:
            return WSSession.activeSession().isValidSession()
        }
    }
    
    func connectionWithRequest(_ apiRequest: WSAPIRequest) -> DataRequest {
        return self.connectionWithRequest(apiRequest, success: nil, failure: nil)
    }
    
    func connectionWithRequest(_ apiRequest: WSAPIRequest, success: ((JSON) ->
        Void)!, failure:((Error) -> Void)!) -> DataRequest {
        var dataRequest : DataRequest!
        dataRequest = WSHTTPSessionManager.performRequest(apiRequest, success: { (response) in
            self.didPerformRequest(apiRequest)
            self.request(apiRequest, didReceiveResponse: response, success: success)
        }, failure: { (error) in
            self.didPerformRequest(apiRequest)
            self.remoteRequestDidFail(apiRequest, error, failure: failure)
        })
        return dataRequest
    }
    
    func request(_ apiRequest: WSAPIRequest, didReceiveResponse response : JSON, success: ((JSON) ->
        Void)!) { //handle response either insert into database and notify controller or use local notification to notifiy
        switch apiRequest.requestType {
            case .APIRequestOTPConfirmation?:
                WSSessionManager.sessionManager.setAccessToken(response["access_token"] as! String)
                success(response as AnyObject)
                return
            case .APIRequestMeetingRoomDashboard?:
                let object = Mapper<WSMeetingRoomDashboard>().map(JSON: response["meeting_room_dashboard"] as! [String : Any])!
                success(object as AnyObject)
                return
            case .APIRequestGetCurrentMember?, .APIRequestUpdateCurrentMember?:
                let userObject = Mapper<WSMember>().map(JSON: response["user"] as! [String : Any])!
                WSSessionManager.sessionManager.setCurrentUser(userObject)
                success(userObject as AnyObject)
                return
            case .APIRequestVendors?:
                let responseObject = response["vendors"] as! NSArray
                var arrayObject : [WSVendor] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSVendor>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMeetingRooms?:
                let responseObject = response["meeting_rooms"] as! NSArray
                var arrayObject : [WSMeetingRoom] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMeetingRoom>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMeetingRoomSlots?:
                let responseObject = response["meeting_room_bookings"] as! NSArray
                var arrayObject : [WSMeetingRoomSlot] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMeetingRoomSlot>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMeetingRoomHistory?:
                let responseObject = response["meeting_rooms_history"] as! NSArray
                var arrayObject : [WSMeetingRoomHistory] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMeetingRoomHistory>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestEvents?:
                let responseObject = response["events"] as! NSArray
                var arrayObject : [WSEvent] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSEvent>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMembers?:
                let responseObject = response["members"] as! NSArray
                var arrayObject : [WSMember] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMember>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestCompanies?:
                let responseObject = response["companies"] as! NSArray
                var arrayObject : [WSCompany] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSCompany>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestNearByWorkspaces?:
                let responseObject = response as? NSArray
                var arrayObject : [WSWorkspace] = []
                for value in responseObject! {
                    arrayObject.append(Mapper<WSWorkspace>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMemberWallFeeds?:
                let responseObject = response["member_walls"] as! NSArray
                var arrayObject : [WSMemberWall] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMemberWall>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMemberWallFeedCommentList?:
                let responseObject = response["member_wall_comments"] as! NSArray
                var arrayObject : [WSMemberWallComments] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMemberWallComments>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMemberWallFeedLikeList?:
                let responseObject = response["member_wall_likes"] as! NSArray
                var arrayObject : [WSMemberWallLikes] = []
                for value in responseObject {
                    arrayObject.append(Mapper<WSMemberWallLikes>().map(JSON: value as! [String : Any])!)
                }
                success(arrayObject as AnyObject)
                return
            case .APIRequestMeetingRoomBooking?, .APIRequestMeetingRoomCancel?:
                success(response as JSON)
                return

            case .APIRequestRandomCode?:
                WSSessionManager.sessionManager.setAccessToken(response["access_token"] as! String)
                success(response as JSON)
                return
            default:
                success(response as JSON)
                break
        }
    }
    
    func didPerformRequest(_ apiRequest : WSAPIRequest) {
        apiRequest.completed = true
    }
    
    func remoteRequestDidFail(_ apiRequest: WSAPIRequest, _ error : Error, failure:((Error) -> Void)!) { //handle error with custom error and use local notification for error
        failure(error)
    }
    
    func JSONString(object : JSON) -> String? {
        return object as? String
    }
    
    func JSONInt(object : JSON) -> Int? {
        return object as? Int
    }
    
    func JSONObject(object : JSON) -> JSONDictionary? {
        return object as? JSONDictionary
    }

    //Reachability
    func isReachable() -> Bool {
        return true
    }
    
    func isReachableWithAlert() -> Bool {

        return true
    }
    
    func startMonitoringReachability() {
        reachability.whenReachable = { reachability in

        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                //let banner = StatusBarNotificationBanner(title: "No internet connectivity", style: .danger)
                //banner.show()
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

}


//
//  WSHTTPSessionManager.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 12/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Alamofire

class WSHTTPSessionManager : SessionManager {
    class var sharedInstance : WSHTTPSessionManager {
        struct Singleton {
            static let instance = WSHTTPSessionManager(configuration: URLSessionConfiguration.default)
        }
        
        return Singleton.instance
    }
    
    class func performRequest(_ apiRequest: WSAPIRequest, success: ((JSON) ->
        Void)!, failure:((Error) -> Void)!) -> DataRequest {
        let fullUrlString = self.fullPathForRequest(apiRequest)
        print(fullUrlString)
        print(apiRequest.params)
        var sessionManager : DataRequest!
        switch apiRequest.requestMethod {
        case WSRequestMethod.RequestMethodGet?:
            
            sessionManager = WSHTTPSessionManager.sharedInstance.request(fullUrlString).responseJSON { response in
                print(response.request?.description ?? "")
                switch (response.result) {
                case .success:
                    switch (response.response?.statusCode) {
                        case 200?:
                            if response.result.value is Array<Any> {
                                success(response.result.value as JSON)
                            } else if response.result.value is Dictionary<String, Any> {
                                success(response.result.value as JSON)
                            } else {
                                success(NSArray.init())
                            }
                            break
                        case 400?: //Only because of displaying custom server messages from server #not recommended
                            let responseData = response.result.value as! Dictionary<String, Any>
                            let error: LocalizedDescriptionError = WSError.customError(message: responseData["message"] as! String)
                            failure(error)
                            break
                        case 401?: //access denied invalid token - prefer logout
                            let error: LocalizedDescriptionError = WSError.customError(message: "Access denied invalid token provided.")
                            failure(error)
                            AppDelegate.sharedDelegate.logout()
                            break
                        default:
                            print(response.response?.statusCode ?? "")
                            let error: LocalizedDescriptionError = WSError.customError(message: "Invalid status code")
                            failure(error)
                    }
                    break
                case .failure(let error):
                    failure(error)
                    break
                }
            }
            break
        case WSRequestMethod.RequestMethodPost?:
            sessionManager = WSHTTPSessionManager.sharedInstance.request(fullUrlString, method : .post, parameters : apiRequest.params, encoding: JSONEncoding.default, headers : ["Content-Type" : "application/json"]).responseJSON { response in
                switch (response.result) {
                case .success:
                    switch (response.response?.statusCode) {
                    case 200?:
                        success(response.result.value as JSON)
                        break
                    case 400?: //Only because of displaying custom server messages from server #not recommended
                        let responseData = response.result.value as! Dictionary<String, Any>
                        let error: LocalizedDescriptionError = WSError.customError(message: responseData["message"] as! String)
                        failure(error)
                        break
                    case 401?: //access denied invalid token - prefer logout
                        let error: LocalizedDescriptionError = WSError.customError(message: "Access denied invalid token provided.")
                        failure(error)
                        AppDelegate.sharedDelegate.logout()
                        break
                    default:
                        print(response.response?.statusCode ?? "")
                        let error: LocalizedDescriptionError = WSError.customError(message: "Invalid status code")
                        failure(error)
                    }
                    break
                case .failure(let error):
                    failure(error)
                    break
                }
            }
            break
        case WSRequestMethod.RequestMethodPut?:
            
            break
        case WSRequestMethod.RequestMethodDelete?:
            
            break
        default:
            break
        }
        WSTracking.trackRequest(apiRequest)
        return sessionManager;
    }
    
    class func fullPathForRequest(_ apiRequest : WSAPIRequest) -> String {
        var fullPath = self.fullPathWithUrlString(apiRequest.urlString!, apiRequest.requestType!)
        switch apiRequest.requestType {
            case .APIRequestLogin?,
                 .APIRequestForgotPasswordEmail?,
                 .APIRequestRandomCode?,
                 .APIRequestSignUp?:
                fullPath = "\(WSAPIConstant.baseUrl())\(fullPath)"
                break
            case .APIRequestForgotPasswordChange?:
                fullPath = "\(WSAPIConstant.baseUrl())\(fullPath)?access_token=\(WSSession.activeSession().accessToken())"
                break
            default:
                fullPath = "\(WSAPIConstant.baseUrl())\(fullPath)?access_token=\(WSSession.activeSession().accessToken())"
                break
        }
        
        return fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    class func fullPathWithUrlString(_ urlString : String, _ apiRequestType : WSAPIRequestType) -> String {
        if (!urlString.isEmpty) {
            var apiVersion = ""
            switch apiRequestType {
            case .APIRequestGetUser,
                 .APIRequestLogin,
                 .APIRequestRandomCode,
                 .APIRequestSignUp,
                 .APIRequestForgotPasswordEmail,
                 .APIRequestUpdateDeviceToken,
                 .APIRequestUpdateUser,
                 .APIRequestForgotPasswordChange:
                apiVersion = WSAPIConstant.apiVersion1
                break
            case .APIRequestOTPLogin,
                 .APIRequestOTPConfirmation,
                 .APIRequestEventAttend,
                 .APIRequestEventUnAttend,
                 .APIRequestVendors,
                 .APIRequestUpdateMemberFirebaseKey:
                apiVersion = WSAPIConstant.apiVersion2
                break
            case .APIRequestMembers,
                 .APIRequestMeetingRooms,
                 .APIRequestMeetingRoomSlots,
                 .APIRequestMeetingRoomHistory,
                 .APIRequestMeetingRoomBooking,
                 .APIRequestMeetingRoomCancel,
                 .APIRequestEvents,
                 .APIRequestMemberWallFeeds,
                 .APIRequestMemberWallFeedCommentList,
                 .APIRequestMemberWallFeedLikeList,
                 .APIRequestCreateMemberWallPost,
                 .APIRequestCreateMemberWallFeedComment,
                 .APIRequestCreateMemberWallFeedLike,
                 .APIRequestDeleteMemberWallPost,
                 .APIRequestDeleteMemberWallFeedComment,
                 .APIRequestDeleteMemberWallFeedLike,
                 .APIRequestMeetingRoomDashboard,
                 .APIRequestCompanies:
                apiVersion = WSAPIConstant.apiVersion2 + "\(WSSession.activeSession().currentVendor().id!)/"
                break
            default:
                apiVersion = WSAPIConstant.apiVersion2
                break
            }
            return String.init(format: "%@%@", apiVersion, urlString)
        } else {
            print("Empty URL string")
            return ""
        }
    }
    
}

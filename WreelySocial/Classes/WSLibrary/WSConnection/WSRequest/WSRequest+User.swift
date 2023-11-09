//
//  WSRequest+User.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation

extension WSRequest {
    class func getCurrentUserId() -> String? {
        return WSFirebaseRequest().firebaseCurrentUserId()
    }

    class func userOTPLogin(_ countryCode: String, _ mobileNumber: String, _ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.otpLogin(countryCode, mobileNumber, success: success, failure: failure)
    }
    
    class func userOTPConfirmation(_ loginCode: String, _ memberId: String, _ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.otpConfirmationLogin(loginCode, memberId, success: success, failure: failure)
    }

    class func userFirebaseKeyUpdate(_ firebaseKey: String, _ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.userFirebaseKeyUpdate(firebaseKey, success: success, failure: failure)
    }

    class func userProfileUpdate(_ data : [String : Any], _ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.userProfileUpdate(data, success: success, failure: failure)
    }

    class func fetchCurrentMember( _ success:((AnyObject) -> Void)!, failure:((Error) -> Void)!) {
        WSAPIRequest.getMember([:], success: success, failure: failure)
    }
    
    class func userLogin(_ username: String, _ password: String, _ success:((AnyObject) -> Void)!, failure:((AnyObject) -> Void)!) {
        WSFirebaseRequest.firebaseUserLogin(username, password, success, failure: failure)
    }
    
    class func userForgotPassword(_ email: String, _ success:(() -> Void)!, failure:((AnyObject) -> Void)!) {
        WSFirebaseRequest.firebaseUserForgotPassword(email, success, failure: failure)
    }
    
    class func updateDataForCurrentUser(_ data : [String : Any]) {
        WSFirebaseRequest().firebaseUpdateKeyValueForCurrentUser(data)
    }
    
    class func addDataForCurrentUser(_ data : [String : Any]) {
        WSFirebaseRequest().firebaseAddKeyValueForCurrentUser(data)
    }
    
    class func fetchFirebaseUserWith(_ firebaseId : String, success:(() -> Void)!, failure:(() -> Void)!) {
        WSFirebaseRequest().firebaseFetchUser(firebaseId, success: success, failure: failure)
    }

    class func fetchFirebaseCurrentUser( _ success:(() -> Void)!) {
        WSFirebaseRequest().firebaseFetchCurrentUser(success)
    }

}

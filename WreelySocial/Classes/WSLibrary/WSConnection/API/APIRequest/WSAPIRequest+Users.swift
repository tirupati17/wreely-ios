//
//  WSAPIRequest+Users.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/02/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation

extension WSAPIRequest {
    
    class func otpLogin(_ countryCode : String, _ mobileNumber : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestOTPLogin)
        let urlString = WSAPIStringUrl.otpLoginEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["mobile_number" : mobileNumber, "country_code" : countryCode, "workspace_name" : WSConstant.WorkspaceDisplayName],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func otpConfirmationLogin(_ loginCode : String, _ memberId : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestOTPConfirmation)
        let urlString = WSAPIStringUrl.otpConfirmationEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["login_code" : loginCode, "member_id" : memberId],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }

    class func getVendors(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestVendors)
        let urlString = WSAPIStringUrl.getVendorsEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func loginWithUsername(_ username : String, _ password : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestLogin)
        let urlString = WSAPIStringUrl.loginEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["email" : username, "password" : password],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func signUpWithData(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestSignUp)
        let urlString = WSAPIStringUrl.signUpEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func userProfileUpdate(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestUserProfileUpdate)
        let urlString = WSAPIStringUrl.updateUserEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: parameters,
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func userFirebaseKeyUpdate(_ firebaseKey : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestUpdateMemberFirebaseKey)
        let urlString = WSAPIStringUrl.updateMemberFirebaseKeyEndpoint(firebaseKey)
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
    
    class func forgotPassEmail(_ email : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestForgotPasswordEmail)
        let urlString = WSAPIStringUrl.forgotPasswordEmailEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["email" : email],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func userRandomCode(_ randomCode : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestRandomCode)
        let urlString = WSAPIStringUrl.randomCodeEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["random_code" : randomCode],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func userConfirmPassword(_ password : String, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestForgotPasswordChange)
        let urlString = WSAPIStringUrl.forgotPasswordChangeEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodPost,
                                        params: ["new_password" : password],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func getMember(_ parameters : [String : Any], success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        let apiRequest = WSAPIRequest.init(requestType: WSAPIRequestType.APIRequestGetCurrentMember)
        let urlString = WSAPIStringUrl.getMemberEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: WSRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
        
    }
}


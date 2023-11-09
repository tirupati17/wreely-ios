//
//  WSSession.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import Firebase

class WSSession {
    
    func currentUser() -> WSMember {
        return WSSessionManager.sessionManager.currentUser
    }
    
    func currentVendor() -> WSVendor {
        return WSSessionManager.sessionManager.currentVendor
    }

    class func activeSession() -> WSSession {
        return WSSessionManager.sessionManager.session
    }
    
    func accessToken() -> String {
        return WSSessionManager.sessionManager.getAccessToken()
    }
    
    func isValidSession() -> Bool {
        return !self.accessToken().isEmpty
    }
    
    func logout() {
        WSSessionManager.sessionManager.currentUser = nil
        self.clear()
    }
    
    func clear() {
        let defaults = UserDefaults.standard
        defaults.removeAll()
        Defaults.removeAll()
    }
}

class WSSessionManager {
    static let sessionManager = WSSessionManager()
    var currentUser : WSMember!
    var currentVendor : WSVendor!
    var accessToken : String!
    var session : WSSession!
    
    init() {
        self.session = WSSession()
    }
    
    func setCurrentUser(_ user: WSMember) {
        self.currentUser = user
    }
    
    func setCurrentVendor(_ vendor: WSVendor) {
        self.currentVendor = vendor
    }
    
    func setAccessToken(_ accessToken: String) {
        UserDefaults.setStandardValue(accessToken, forKey: "access_token")
        self.accessToken = accessToken
    }
    
    func getAccessToken() -> String {
        return UserDefaults.standard.object(forKey: "access_token") != nil ? UserDefaults.getStandardValue("access_token") as! String : ""
    }
}


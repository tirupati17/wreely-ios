//
//  WSFirebaseSession.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 12/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import Firebase

class WSFirebaseSession {
    
    func currentUser() -> WSFIRUser {
        return WSFirebaseSessionManager.sessionManager.currentUser
    }
    
    func currentVendor() -> WSFIRVendor {
        return WSFirebaseSessionManager.sessionManager.currentVendor
    }
    
    class func activeSession() -> WSFirebaseSession {
        return WSFirebaseSessionManager.sessionManager.session
    }
    
    func accessToken() -> String {
        return WSFirebaseSessionManager.sessionManager.accessToken!
    }
    
    func isValidSession() -> Bool {
        if WSFirebaseRequest.firebaseCurrentUser() != nil {
            return true
        } else {
            return false
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
        }
        WSFirebaseSessionManager.sessionManager.currentUser = nil
    }
    
    func clear() {
        Defaults.removeAll()
    }
}

class WSFirebaseSessionManager {
    static let sessionManager = WSFirebaseSessionManager()
    var currentUser : WSFIRUser!
    var currentVendor : WSFIRVendor!
    var accessToken : String? = ""
    var session : WSFirebaseSession!
    
    init() {
        self.session = WSFirebaseSession()
    }
    
    func setCurrentUser(_ user: WSFIRUser) {
        self.currentUser = user
    }
    
    func setCurrentVendor(_ vendor: WSFIRVendor) {
        self.currentVendor = vendor
        self.accessToken = vendor.accessToken
    }
}

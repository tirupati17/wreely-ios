//
//  WSTracking.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 06/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import OneSignal
import Mixpanel
import Fabric
import Answers
import Firebase

class WSTracking {
    static var sharedTracking = WSTracking()
    let mixpanel = Mixpanel.mainInstance()
    func setupInitialTracking() {
        guard let user = WSSession.activeSession().currentUser() as WSMember? else {
            return
        }
        OneSignal.setEmail(user.emailId!)
        self.trackProfile(user)
    }
    
    func trackProfile(_ user : WSMember) {
        self.mixpanel.createAlias("\(user.id!)",
            distinctId: (mixpanel.distinctId))
        self.mixpanel.identify(distinctId: (mixpanel.distinctId))
        self.mixpanel.people.set(property: "$name",to: user.name!)
        self.mixpanel.people.set(property: "$phone",to: user.contactNo!)
        self.mixpanel.people.set(property: "$email",to: user.emailId!)
        self.mixpanel.people.set(property: "Occupation",to: user.occupation!)
        self.mixpanel.people.set(property: "Company Name",to: user.companyName!)
        guard let deviceToken = Defaults[.deviceToken] as? String else {
            return
        }
        self.mixpanel.people.set(property: "$ios_devices",to: deviceToken)
    }
    
    class func startSession() {
        
    }
    
    class func setCurrentUser() {
        
    }
    
    class func logEvent(_ evenName : String, customAttributesOrProperties:[String:Any]? = [:]) {
        Mixpanel.mainInstance().track(event: evenName, properties: customAttributesOrProperties as? Properties)
        Answers.logCustomEvent(withName: evenName, customAttributes: customAttributesOrProperties)
        Analytics.logEvent(evenName, parameters: customAttributesOrProperties)
    }
    
    class func logPurchaseEventWithValue(_ value : String, _ currency : String) {
        
    }
    
    class func logError(_ errorId : String, _ message : String, _ error : Error) {
        
    }
        
    class func trackRequest(_ request : WSAPIRequest) {
    
    }
    
    class func shouldTrackRequest(_ request : WSAPIRequest) {
        
    }
}

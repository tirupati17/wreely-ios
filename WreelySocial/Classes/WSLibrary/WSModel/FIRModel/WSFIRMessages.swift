//
//  WSFIRMessages.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase

class WSFIRMessages {
    var messageFirebaseId : String? = ""
    var memberId : Int? = 0
    var incoming : Bool? = false
    var message : String? = ""
    var receiverFirebaseId : String? = ""
    var roomId : String? = ""
    var senderFirebaseId : String? = ""
    var timestamp : Double? = 0
    var userName : String? = ""
    var profilePicUrl : String? = ""

    init(snapshot : DataSnapshot? = nil) {
        guard let value = snapshot?.value as? [String : Any]  else {
            return
        }
        self.messageFirebaseId = snapshot?.key //message firebase id not user related
        if let message = value["message"] as? String {
            self.message = message
        }
        if let incoming = value["incoming"] as? Bool {
            self.incoming = incoming
        }
        if let receiverFirebaseId = value["receiverFirebaseId"] as? String {
            self.receiverFirebaseId = receiverFirebaseId
        }
        if let senderFirebaseId = value["senderFirebaseId"] as? String {
            self.senderFirebaseId = senderFirebaseId
        }
        if let timestamp = value["timestamp"] as? Double {
            self.timestamp = timestamp
        }
        if let userName = value["userName"] as? String {
            self.userName = userName
        }
        if let memberId = value["memberId"] as? Int {
            self.memberId = memberId
        }
        if let profilePicUrl = value["profilePicUrl"] as? String {
            self.profilePicUrl = profilePicUrl
        }
    }
    
    func returnFirebaseCompatibleDictionary() -> [String : AnyObject] {
        return ["profilePicUrl": self.profilePicUrl as AnyObject,
                "incoming": self.incoming as AnyObject,
                "receiverFirebaseId": self.receiverFirebaseId as AnyObject,
                "message": self.message as AnyObject,
                "senderFirebaseId": self.senderFirebaseId as AnyObject,
                "messageFirebaseId": self.messageFirebaseId as AnyObject,
                "timestamp": self.timestamp as AnyObject,
                "memberId": self.memberId as AnyObject,
                "userName": self.userName as AnyObject]
    }
    
    func isCurrentUser() -> Bool {
        return self.senderFirebaseId == WSFirebaseSession.activeSession().currentUser().firebaseId
    }
}

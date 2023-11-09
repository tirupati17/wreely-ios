//
//  WSFirebaseRequest+Users.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

extension WSFirebaseRequest {

    class func firebaseCurrentUser() -> User? {
        return Auth.auth().currentUser
    }

    func firebaseCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    class func firebaseAnonymousLogin(_ success:((AnyObject) -> Void)!, failure:((AnyObject) -> Void)!) {
        Auth.auth().signInAnonymously { (result, error) in
            if error == nil {
                WSFirebaseSessionManager.sessionManager.setCurrentUser(WSFIRUser.init(user: result!.user))
                success?(result!.user)
            } else {
                failure?(error! as AnyObject)
            }
        }
    }
    
    class func firebaseUserLogin(_ username: String, _ password: String, _ success:((AnyObject) -> Void)!, failure:((AnyObject) -> Void)!) {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error == nil {
                WSFirebaseSessionManager.sessionManager.setCurrentUser(WSFIRUser.init(user: result!.user))
                success?(result!.user)
            } else {
                failure?(error! as AnyObject)
            }
        }
    }
    
    class func firebaseUserSignUp(_ username: String, _ password: String, _ success:((AnyObject) -> Void)!, failure:((AnyObject) -> Void)!) {
        Auth.auth().createUser(withEmail: username, password: password, completion: { (result, error) in
            if error == nil {
                WSFirebaseSessionManager.sessionManager.setCurrentUser(WSFIRUser.init(user: result!.user))
                success?(result!.user)
            } else {
                failure?(error! as AnyObject)
            }
        })
    }
    
    class func firebaseUserForgotPassword(_ email: String, _ success:(() -> Void)!, failure:((AnyObject) -> Void)!) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                success?()
            } else {
                failure?(error! as AnyObject)
            }
        })
    }

    func firebaseAddKeyValueForCurrentUser(_ data : [String : Any]) {
        for (key, value) in data {
            self.firebaseManager.ref.child("users").child(self.firebaseCurrentUserId()!).setValue([key:value])
        }
    }
    
    func firebaseUpdateKeyValueForCurrentUser(_ data : [String : Any]) {
        for (key, value) in data {
            self.firebaseManager.ref.child("users/\(self.firebaseCurrentUserId()!)/\(key)").setValue(value)
        }
    }

    func firebaseFetchUser(_ firebaseId : String, success:(() -> Void)!, failure:(() -> Void)!) {
        self.firebaseDatabaseReference(.members)?.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(firebaseId){
                self.firebaseDatabaseReference(.members)?.child(firebaseId).observe(DataEventType.value, with: { (snapshot) in
                    WSFirebaseSessionManager.sessionManager.setCurrentUser(WSFIRUser.init(snapshot: snapshot))
                    success()
                })
            } else {
                failure()
            }
        })
    }

    func firebaseFetchCurrentUser(_ success:(() -> Void)!) {
        self.firebaseDatabaseReference(.members)?.child(self.firebaseCurrentUserId()!).observe(DataEventType.value, with: { (snapshot) in
            WSFirebaseSessionManager.sessionManager.setCurrentUser(WSFIRUser.init(snapshot: snapshot))
            success()
        })
    }
    
    func firebaseObserveMessages(_ firebaseDataBaseRef: FirebaseDatabaseRef, withChatRoomId: String, success:((Any?) -> Void)!) {
        let ref = (self.firebaseDatabaseReference(firebaseDataBaseRef)?.child(withChatRoomId).queryLimited(toLast: 500))!
        ref.observe(.value, with: { (snapshot) in
            var messageList = [WSFIRMessages]()
            if let data = snapshot.children.allObjects as? [DataSnapshot], !data.isEmpty {
                for index in stride(from:0, to:data.count, by:1) {
                    messageList.append(WSFIRMessages.init(snapshot: data[index]))
                }
            }
            success?(messageList)
        })
    }
    
    func firebaseSendMessages(_ firebaseDataBaseRef: FirebaseDatabaseRef, withChatRoomId: String, data : WSFIRMessages) {
        let ref: DatabaseReference
        ref = (self.firebaseDatabaseReference(firebaseDataBaseRef)?.child(withChatRoomId).childByAutoId())!
        
        var postData = data.returnFirebaseCompatibleDictionary()
        postData["timestamp"] = ServerValue.timestamp() as AnyObject //Create server side timestamp instead at local end
        postData["messageFirebaseId"] = ref.key as AnyObject
        
        ref.setValue(postData)
    }

}

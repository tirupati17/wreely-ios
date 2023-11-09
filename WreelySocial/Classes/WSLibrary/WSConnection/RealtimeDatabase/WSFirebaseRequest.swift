//
//  WSFirebaseRequest.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 04/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

enum FirebaseDatabaseRef : Int {
    case vendors = 1
    case members = 2
    case companies = 3
    case oneToOneChat = 4
    case groupChat = 5
    case root = 6
}

class WSFirebaseRequest {
    var firebaseManager = WSFirebaseManager.init()
    lazy var uid = Auth.auth().currentUser!.uid
    
    var query: DatabaseReference!
    var observers = [DatabaseQuery]()
    
    func firebaseSetValue(forChild name:String, childId id:String, withData data:[String:AnyObject]) {
        self.firebaseManager.ref.child(name).child(id).setValue(data)
    }
    
    func firebaseDatabaseReference(_ firebaseDatabaseRef : FirebaseDatabaseRef) -> DatabaseReference? {
        switch firebaseDatabaseRef {
            case FirebaseDatabaseRef.vendors:
                self.query = self.firebaseManager.ref.child("vendors")
                break;
            case FirebaseDatabaseRef.members:
                self.query = self.firebaseManager.ref.child("users")
                break;
            case FirebaseDatabaseRef.companies:
                self.query = self.firebaseManager.ref.child("companies")
                break;
            case FirebaseDatabaseRef.oneToOneChat:
                self.query = self.firebaseManager.ref.child("oneToOneChat")
                break;
            case FirebaseDatabaseRef.groupChat:
                self.query = self.firebaseManager.ref.child("groupChat")
                break;
            default:
                self.query = Database.database().reference()
                break;
        }
        return self.query
    }
}

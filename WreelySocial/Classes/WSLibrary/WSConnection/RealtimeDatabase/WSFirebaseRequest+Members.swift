//
//  WSFirebaseRequest+Members.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

extension WSFirebaseRequest {
    func firebaseFetchMembersForCurrentUser(_ success:((Any?) -> Void)!) {
        var memberList = [WSFIRUser]()
        self.firebaseDatabaseReference(.members)?.queryOrdered(byChild: "vendor_id").queryEqual(toValue: WSFirebaseSession.activeSession().currentVendor().vendorSqlId).observe(DataEventType.value, with: { (snapshot) in
            if let data = snapshot.children.allObjects as? [DataSnapshot], !data.isEmpty {
                for index in stride(from: 0, to:data.count, by: 1) {
                    memberList.append(WSFIRUser.init(snapshot: data[index]))
                }
            }
            success?(memberList)
        })
    }
}

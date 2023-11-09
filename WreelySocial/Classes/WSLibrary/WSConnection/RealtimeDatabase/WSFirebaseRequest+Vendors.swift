//
//  WSFirebaseRequest+Vendors.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 08/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

extension WSFirebaseRequest {
    
    func firebaseFetchWorkspaceForCurrentUser(_ success:((Any?) -> Void)!) {
        var vendorList = [WSFIRVendor]()
        self.firebaseDatabaseReference(.vendors)?.observe(DataEventType.value, with: { (snapshot) in
            if let data = snapshot.children.allObjects as? [DataSnapshot], !data.isEmpty {
                for index in stride(from: 0, to:data.count, by: 1) {
                    vendorList.append(WSFIRVendor.init(snapshot: data[index]))
                }
            }
            success?(vendorList)
        })
    }
}

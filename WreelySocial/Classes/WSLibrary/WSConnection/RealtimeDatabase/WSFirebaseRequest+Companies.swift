//
//  WSFirebaseRequest+Companies.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

extension WSFirebaseRequest {
    func firebaseFetchCompaniesForCurrentUser(_ success:((Any?) -> Void)!) {
        var companyList = [WSFIRCompany]()
        self.firebaseDatabaseReference(.companies)?.queryOrdered(byChild: "vendor_id").queryEqual(toValue: WSFirebaseSession.activeSession().currentVendor().vendorSqlId).observe(DataEventType.value, with: { (snapshot) in
            if let data = snapshot.children.allObjects as? [DataSnapshot], !data.isEmpty {
                for index in stride(from: 0, to:data.count, by: 1) {
                    companyList.append(WSFIRCompany.init(snapshot: data[index]))
                }
            }
            success?(companyList)
        })
    }
}

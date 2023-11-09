//
//  Dictionary+Extension.swift
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation

extension Dictionary {
    func toData() -> NSData? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}

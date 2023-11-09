//
//  Data+Extension.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation


extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            WSLogger.log(error)
            return  nil
        }
    }
    
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
    
    func dataToJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        } catch let myJSONError {
            WSLogger.log(myJSONError)
        }
        return nil
    }

    var bytes: [UInt8] {
        return [UInt8](self)
    }
}

//
//  String+Extension.swift
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func isValidString(_ string : String) -> Bool {
        return !string.isEmpty
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    static func randomId() -> String { //All other func or may be few in this string extension should be static
        return String(format: "%08x%08x", arc4random(), arc4random())
    }
    
    /// Encodes or decodes into a base64url safe representation
    ///
    /// - Parameter on: Whether or not the string should be made safe for URL strings
    /// - Returns: if `on`, then a base64url string; if `off` then a base64 string
    func toggleBase64URLSafe(on: Bool) -> String {
        if on {
            // Make base64 string safe for passing into URL query params
            let base64url = self.replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "=", with: "")
            return base64url
        } else {
            // Return to base64 encoding
            var base64 = self.replacingOccurrences(of: "_", with: "/")
                .replacingOccurrences(of: "-", with: "+")
            // Add any necessary padding with `=`
            if base64.count % 4 != 0 {
                base64.append(String(repeating: "=", count: 4 - base64.count % 4))
            }
            return base64
        }
    }
    
    var base64StringToHtmlString: String {
        let decodedData = Data(base64Encoded: self)!
        let decodedString = String(data: decodedData, encoding: .utf8)!
        
        return decodedString.html2String
    }
    
    var getLastPathOfUrlString: String {
        let url = URL(string: self)
        return (url?.lastPathComponent)!
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    var toFormattedDateString: String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = WSConstant.ServerDateFormat
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        return date.toServerDateString
    }
    
    var toServerDate : Date {
        return WSConstant.GetServerDateFormat.date(from: self)!
    }
    
    func toInt() -> Int {
        return Int(self)!
    }
    
    func toDouble() -> Double {
        if self.isEmpty {
            return 0
        }
        return Double(self)!
    }
    
    func removeWhitespace() -> String {
        return self.components(separatedBy: .whitespaces).joined()
    }
}

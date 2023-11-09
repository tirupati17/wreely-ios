//
//  NSBundle+Extension.swift
//  SKYApp
//
//  Created by Tirupati Balan on 11/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension Bundle {
    class func getDocumentPathUrl() -> URL {
        let documentPathUrl = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!, isDirectory: true)
        
        return documentPathUrl
    }

    class func getDocumentPathUrlForFile(_ fileName: String) -> URL {
        return Bundle.getDocumentPathUrl().appendingPathComponent(fileName)
    }

    class func getDocumentPathString() -> String {
        return Bundle.getDocumentPathUrl().path
    }

    class func getDocumentPathStringForFile(_ fileName: String) -> String {
        return Bundle.getDocumentPathUrl().appendingPathComponent(fileName).path
    }
    
    class func isFileExist(_ fileName : String) -> Bool {
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: Bundle.getDocumentPathStringForFile(fileName))) {
            return true
        } else {
            //TBLogger.log("File not found at path \(Bundle.getDocumentPathStringForFile(fileName))");
            return false
        }
    }
}

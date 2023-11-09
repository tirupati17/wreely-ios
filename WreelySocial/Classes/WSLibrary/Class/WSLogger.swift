//
//  WSLogger.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 06/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Log //check if Log framework exist then only use his classes

enum LogType : Int {
    case kTrace = 1 //Default black
    case kDebug = 2
    case kInfo = 3
    case kWarning = 4
    case kError = 5
}

class WSLogger {
    class func log(_ logString : Any, logType : LogType? = .kTrace) {
        let log = Logger()
        switch logType {
            case .kDebug?:
                log.debug(logString)
                break
            case .kInfo?:
                log.info(logString)
                break
            case .kWarning?:
                log.warning(logString)
                break
            case .kError?:
                log.error(logString)
                break
            default:
                log.trace(logString)
        }
    }
}

//
//  Date+Extension.swift
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation

enum StartEndOfDate {
    case kDay
    case kWeek
    case kMonth
    case kQuarter
    case kYear
}

enum DateFormateStyle {
    
}

let tSecond : TimeInterval = 1
let tMinute : TimeInterval = tSecond * 60
let tHour : TimeInterval = tMinute * 60
let tHalfDay : TimeInterval = tHour * 12
let tDay : TimeInterval = tHalfDay * 2
let tWeek : TimeInterval = tDay * 7
let tYear : TimeInterval = tDay * 365

extension Date {
    
    func addDay(_ day : Int) -> Date {
        return Date(timeIntervalSinceNow: Double(day * Int(tDay)))
    }
    
    var getCurrentDateString : String {
        return WSConstant.GetServerDateFormat.string(from: Date.init())
    }
    
    var isPastDate : Bool {
        return self.timeIntervalSinceNow.sign == .minus
    }

    func getStartOf(_ startOf : StartEndOfDate) -> Date {
        switch startOf {
            case .kDay:
                return Calendar.current.startOfDay(for: self)
            case .kWeek:
                break
            case .kMonth:
                return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self.getStartOf(.kDay)))!
            case .kQuarter:
                break
            default:
                break
        }
        return Date.init()
    }
    
    func getEndOf(_ endOf : StartEndOfDate) -> Date {
        switch endOf {
            case .kDay:
                return Calendar.current.startOfDay(for: self).addingTimeInterval(tDay - 1)
            case .kWeek:
                break
            case .kMonth:
                return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.getStartOf(.kMonth))!
            default:
                break
        }
        return Date.init()
    }

    var toNormalDateString : String {
        return WSConstant.GetNormalDateFormat.string(from: self)
    }
    
    var toServerDateString : String {
        return WSConstant.GetServerDateFormat.string(from: self)
    }
    
    var toTimeString : String {
        return WSConstant.GetTimeFormat.string(from: self)
    }
    
    var to24HourTimeString : String {
        return WSConstant.Get24HourTimeFormat.string(from: self)
    }
}

//
//  Date.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

// NOTE : - ミリ秒マイクロ秒は扱わないクラス
class Date {

    class func now() -> Int {
        let date: NSDate = NSDate()
        return Int(date.timeIntervalSince1970)
    }

    class func day() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit = [.Era, .Year, .Month, .Day]
        let dateComponents = calendar.components(unitFlags, fromDate: NSDate())
        return dateComponents.day
    }

    class func getHourMinuteString(unixTime:Double) -> String {
        let date: NSDate = NSDate(timeIntervalSince1970: unixTime)
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let calendarComponent = calendar.components(
            [NSCalendarUnit.Hour, NSCalendarUnit.Minute],
            fromDate: date
        )
        return String(
            format: NSLocalizedString("degitalClock", comment: ""),
            calendarComponent.hour, calendarComponent.minute
        )
    }

    // TODO : - あとで用途に合わせて修正
    class func getUntilTime(unixtTime:Int) -> String {
        var untilTimeString: String
        let untilSec = unixtTime - now()
        if untilSec <= 0 {
            untilTimeString = NSLocalizedString("allRecovery", comment: "")
        } else if untilSec < 60 {
            untilTimeString = String(
                format: NSLocalizedString("degitalClockForRecovery", comment: ""),
                0, untilSec
            )
        } else if untilSec < 60 * 60 {
            let min = untilSec / 60
            let sec = untilSec % 60
            untilTimeString = String(
                format: NSLocalizedString("degitalClockForRecovery", comment: ""),
                min, sec
            )
        } else {
            let hour = untilSec / 60 * 60
            let min = untilSec % 60 * 60
            untilTimeString = String(
                format: NSLocalizedString("degitalClockForRecovery", comment: ""),
                hour, min
            )
        }
        return untilTimeString
    }
}

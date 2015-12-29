//
//  DateHelpers.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/28/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

class DateHelpers {
  /**
   @returns today's date at midnight
  */
  static func getTodaysDay() -> NSDate {
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .NoStyle
    dateFormatter.dateStyle = .ShortStyle

    return dateFormatter.dateFromString(
      dateFormatter.stringFromDate(NSDate())
    )!
  }

  /**
   @returns tomorrow's date at midnight
  */
  static func getTomorrowsDay() -> NSDate {
    return NSCalendar.currentCalendar().dateByAddingUnit(
      .Day,
      value: 1,
      toDate: self.getTodaysDay(),
      options: NSCalendarOptions(rawValue: 0)
    )!
  }

  /**
   @returns yesterday's date at midnight
  */
  static func getYesterdaysDay() -> NSDate {
    return NSCalendar.currentCalendar().dateByAddingUnit(
      .Day,
      value: -1,
      toDate: self.getTodaysDay(),
      options: NSCalendarOptions(rawValue: 0)
    )!
  }

}

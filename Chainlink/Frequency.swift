//
//  Frequency.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/19/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

enum DayOfTheWeek: Int {
  case SUNDAY = 64
  case MONDAY = 32
  case TUESDAY = 16
  case WEDNESDAY = 8
  case THURSDAY = 4
  case FRIDAY = 2
  case SATURDAY = 1
}

class Frequency: NSObject {
  var intValue: Int
  init(intValue: Int) {
    self.intValue = intValue
  }

  func setDayOfTheWeek(dayOfTheWeek: DayOfTheWeek) -> Void {
    self.intValue |= dayOfTheWeek.rawValue
  }

  func unsetDayOfTheWeek(dayOfTheWeek: DayOfTheWeek) -> Void {
    self.intValue ^= dayOfTheWeek.rawValue
  }

  func isDayOfTheWeekSet(dayOfTheWeek: DayOfTheWeek) -> Bool {
    return Bool(self.intValue & dayOfTheWeek.rawValue)
  }

  func isEveryDay() -> Bool {
    return self.intValue == 127
  }

  func isOff() -> Bool {
    return self.intValue == 0
  }
}
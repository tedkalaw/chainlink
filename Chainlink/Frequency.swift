//
//  Frequency.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/19/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

enum DayOfTheWeek {
  case SUNDAY
  case MONDAY
  case TUESDAY
  case WEDNESDAY
  case THURSDAY
  case FRIDAY
  case SATURDAY
}

class Frequency: NSObject {
  var intValue: Int
  init(intValue: Int) {
    self.intValue = intValue
  }

  func setDayOfTheWeek(dayOfTheWeek: DayOfTheWeek) -> Void {
    switch (dayOfTheWeek) {
    case .SUNDAY:
      self.intValue = self.intValue | 1 << 6
      break
    case .MONDAY:
      self.intValue = self.intValue | 1 << 5
      break
    case .TUESDAY:
      self.intValue = self.intValue | 1 << 4
      break
    case .WEDNESDAY:
      self.intValue = self.intValue | 1 << 3
      break
    case .THURSDAY:
      self.intValue = self.intValue | 1 << 2
      break
    case .FRIDAY:
      self.intValue = self.intValue | 1 << 1
      break
    case .SATURDAY:
      self.intValue = self.intValue | 1
      break
    }
  }

  func isEveryDay() -> Bool {
    return self.intValue == 127
  }

  func isOff() -> Bool {
    return self.intValue == 0
  }
}
//
//  LinkModel.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/6/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

class LinkModel: NSObject {
  var date: NSDate;

  init(date: NSDate) {
    self.date = date
    super.init();
  }

  func dateString() -> String {
    let dateFormatter = NSDateFormatter()
    let locale = NSLocale(localeIdentifier: "en_US_POSIX")

    dateFormatter.locale = locale
    dateFormatter.dateFormat = "MM-dd-yyyy"

    return dateFormatter.stringFromDate(self.date)
  }
}

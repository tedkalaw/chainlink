//
//  LinkModel.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/6/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

let kLinkModelDateKey = "linkModelDate"

class LinkModel: NSObject, NSCoding {
  var date: NSDate;

  init(date: NSDate) {
    self.date = date
    super.init();
  }

  required init?(coder aDecoder: NSCoder) {
    self.date = aDecoder.decodeObjectForKey(kLinkModelDateKey) as! NSDate
  }

  func encodeWithCoder(aCoder: NSCoder) -> Void {
    aCoder.encodeObject(self.date, forKey: kLinkModelDateKey)
  }

  func dateString() -> String {
    let dateFormatter = NSDateFormatter()
    let locale = NSLocale(localeIdentifier: "en_US_POSIX")

    dateFormatter.locale = locale
    dateFormatter.dateFormat = "MM-dd-yyyy 'at' hh:mm a"

    return dateFormatter.stringFromDate(self.date)
  }
}

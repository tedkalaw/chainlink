//
//  Chain.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/25/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import CoreData


class Chain: NSManagedObject {

  static func entityName() -> String {
    return "Chain"
  }

  static func allFetchRequest() -> NSFetchRequest {
    return NSFetchRequest(entityName: self.entityName())
  }

  static func allSortedFetchRequest() -> NSFetchRequest {
    let fetchRequest = self.allFetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

    return fetchRequest
  }

  /**
   Adds a like that has a date/time for right now. Intended to be used for
   */
  func addLinkForNow() -> Void {
    let newLink = Link()
    newLink.time = NSDate()
    self.addLinksObject(newLink)
  }
}

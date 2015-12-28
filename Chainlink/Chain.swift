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
    let newLink = NSEntityDescription.insertNewObjectForEntityForName(
      Link.entityName(),
      inManagedObjectContext: self.managedObjectContext!
    ) as! Link
    newLink.time = NSDate()

    self.addLinksObject(newLink)
  }

  /**
   Returns links sorted by date
   */
  func getSortedLinks() -> [Link] {
    let fetchRequest = NSFetchRequest(entityName: Link.entityName())
    fetchRequest.predicate = NSPredicate(format: "chain == %@", self)

    fetchRequest.sortDescriptors = [
      NSSortDescriptor(key: "time", ascending: false)
    ]

    var sortedLinks = [Link]()
    do {
      sortedLinks = try self.managedObjectContext?.executeFetchRequest(fetchRequest) as! [Link]
    } catch {
      NSLog("getting sorted links failed")
    }

    return sortedLinks
  }
}

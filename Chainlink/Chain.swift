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
   Adds a link that has a date/time for right now. Throws an exception if saving
   fails for some reason
   */
  func addLinkForNowX() throws -> Void {
    let newLink = NSEntityDescription.insertNewObjectForEntityForName(
      Link.entityName(),
      inManagedObjectContext: self.managedObjectContext!
    ) as! Link
    newLink.time = NSDate()

    self.addLinksObject(newLink)
    self.addToConsecutiveLinkCount()
    try self.managedObjectContext!.save()
  }

  func addLinkForNow() -> Void {
    do {
      try self.addLinkForNowX()
    } catch {
      NSLog("Failed to add link")
    }
  }

  private func getBaseLinkFetchRequest() -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName: Link.entityName())
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(key: "time", ascending: false)
    ]

    return fetchRequest
  }

  /**
   Returns links sorted by date
   */
  func getSortedLinks() -> [Link] {
    let fetchRequest = self.getBaseLinkFetchRequest()
    fetchRequest.predicate = NSPredicate(format: "chain == %@", self)

    var sortedLinks = [Link]()
    do {
      sortedLinks = try self.managedObjectContext?.executeFetchRequest(fetchRequest) as! [Link]
    } catch {
      NSLog("getting sorted links failed")
    }

    return sortedLinks
  }

  /**
   @returns all the links that occurred between yesterday at midnight and tomorrow at midnight; i.e., today's links
   */
  func getTodaysLinks() -> [Link] {
    let fetchRequest = self.getBaseLinkFetchRequest()
    fetchRequest.predicate = NSPredicate(
      format: "chain == %@ AND time < %@ AND time > %@",
      self,
      DateHelpers.getTomorrowsDay(),
      DateHelpers.getTodaysDay()
    )

    var sortedLinks = [Link]()
    do {
      sortedLinks = try self.managedObjectContext?.executeFetchRequest(fetchRequest) as! [Link]
    } catch {
      NSLog("getting sorted links failed")
    }

    return sortedLinks
  }

  func getConsecutiveLinkCount() -> Int {
    return (self.consecutiveLinks?.integerValue)!
  }

  func addToConsecutiveLinkCount() -> Void {
    let todaysLinks: [Link] = self.getTodaysLinks()
    if (todaysLinks.count >= self.getLinksToDo()) {
      return
    }

    self.consecutiveLinks = self.consecutiveLinks != nil
      ? self.consecutiveLinks!.integerValue + 1
      : 1
  }

  func getLinksToDo() -> Int {
    // TODO: Make it so this is configurable
    return 1
  }

}

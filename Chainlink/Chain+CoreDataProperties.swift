//
//  Chain+CoreDataProperties.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/29/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Chain {

  @NSManaged var consecutiveLinks: NSNumber?
  @NSManaged var name: String?
  @NSManaged var frequency: NSNumber?
  @NSManaged var dayBitmap: NSNumber?
  @NSManaged var links: NSSet?
  @NSManaged var target: Target?
  
  @NSManaged func addLinksObject(link: Link)
  @NSManaged func removeLinksObject(link: Link)
  @NSManaged func addEmployees(links: NSSet)
  @NSManaged func removeEmployees(links: NSSet)

}

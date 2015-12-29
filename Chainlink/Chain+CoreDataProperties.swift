//
//  Chain+CoreDataProperties.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/28/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

import Foundation
import CoreData

extension Chain {

  @NSManaged var name: String?
  @NSManaged var consecutiveLinks: NSNumber?
  @NSManaged var links: NSSet?

  @NSManaged func addLinksObject(link: Link)
  @NSManaged func removeLinksObject(link: Link)
  @NSManaged func addEmployees(links: NSSet)
  @NSManaged func removeEmployees(links: NSSet)

}

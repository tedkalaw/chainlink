//
//  Link+CoreDataProperties.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/25/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Link {

    @NSManaged var time: NSDate?
    @NSManaged var chain: Chain?

}

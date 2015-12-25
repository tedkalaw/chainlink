//
//  Link+CoreDataProperties.h
//  Chainlink
//
//  Created by Ted Kalaw on 12/24/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Link.h"

NS_ASSUME_NONNULL_BEGIN

@interface Link (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) Chain *chain;

@end

NS_ASSUME_NONNULL_END

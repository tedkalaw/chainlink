//
//  Chain+CoreDataProperties.h
//  Chainlink
//
//  Created by Ted Kalaw on 12/24/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Chain.h"

NS_ASSUME_NONNULL_BEGIN

@interface Chain (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<NSManagedObject *> *links;

@end

@interface Chain (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inLinksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLinksAtIndex:(NSUInteger)idx;
- (void)insertLinks:(NSArray<NSManagedObject *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLinksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLinksAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceLinksAtIndexes:(NSIndexSet *)indexes withLinks:(NSArray<NSManagedObject *> *)values;
- (void)addLinksObject:(NSManagedObject *)value;
- (void)removeLinksObject:(NSManagedObject *)value;
- (void)addLinks:(NSOrderedSet<NSManagedObject *> *)values;
- (void)removeLinks:(NSOrderedSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

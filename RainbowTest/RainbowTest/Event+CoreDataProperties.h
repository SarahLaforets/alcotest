//
//  Event+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 13/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *begin;
@property (nullable, nonatomic, retain) NSDate *end;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Drink *> *refDrink;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addRefDrinkObject:(Drink *)value;
- (void)removeRefDrinkObject:(Drink *)value;
- (void)addRefDrink:(NSSet<Drink *> *)values;
- (void)removeRefDrink:(NSSet<Drink *> *)values;

@end

NS_ASSUME_NONNULL_END

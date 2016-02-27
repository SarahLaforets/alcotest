//
//  Drink+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 13/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Drink.h"

NS_ASSUME_NONNULL_BEGIN

@interface Drink (CoreDataProperties)

@property (nullable, nonatomic, retain) Bar *refBar;
@property (nullable, nonatomic, retain) Verre *refVerre;
@property (nullable, nonatomic, retain) NSNumber *nombre;
@property (nullable, nonatomic, retain) NSDate *time;

@end

NS_ASSUME_NONNULL_END

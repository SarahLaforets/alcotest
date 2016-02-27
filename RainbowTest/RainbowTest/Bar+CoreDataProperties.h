//
//  Bar+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 10/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Bar.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bar (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *degre;

@end

NS_ASSUME_NONNULL_END

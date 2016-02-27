//
//  Verre+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 13/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Verre.h"

NS_ASSUME_NONNULL_BEGIN

@interface Verre (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *quantite;

@end

NS_ASSUME_NONNULL_END

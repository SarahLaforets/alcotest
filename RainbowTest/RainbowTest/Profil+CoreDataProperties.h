//
//  Profil+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 24/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Profil.h"

NS_ASSUME_NONNULL_BEGIN

@interface Profil (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *age;
@property (nullable, nonatomic, retain) NSDecimalNumber *poids;
@property (nullable, nonatomic, retain) NSNumber *sexe;

@end

NS_ASSUME_NONNULL_END

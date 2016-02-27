//
//  Taux+CoreDataProperties.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 24/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Taux.h"

NS_ASSUME_NONNULL_BEGIN

@interface Taux (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDecimalNumber *taux;
@property (nullable, nonatomic, retain) NSDate *moment;
@property (nullable, nonatomic, retain) Profil *refProfil;

@end

NS_ASSUME_NONNULL_END

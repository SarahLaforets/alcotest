//
//  Verre.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 13/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Verre : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void)addVerre:(NSString *)name withQuantity:(NSNumber*)quantity;

- (NSArray *)fetchVerre;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END

#import "Verre+CoreDataProperties.h"

//
//  Bar.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 10/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import "Bar.h"

@implementation Bar

+ (instancetype)sharedInstance {
    static Bar *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Bar alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

// Insert code here to add functionality to your managed object subclass
- (NSArray *)fetchBoisson {
    NSArray *boissons;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bar" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    boissons = [context executeFetchRequest:request error:&error];
    
    return boissons;
}

- (NSArray *)fetchAllBar{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bar" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    NSArray *mBar = [context executeFetchRequest:request error:&error];
    return mBar;
}

- (void)addBarInDataBase:(NSString *)name withDegre:(NSString *)degree {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSManagedObject *bar = [NSEntityDescription insertNewObjectForEntityForName:@"Bar" inManagedObjectContext:context];
    
    [bar setValue:name forKey:@"name"];
    NSNumber  *mDegree = [NSNumber numberWithInteger:[degree integerValue]];
    [bar setValue:mDegree forKey:@"degre"];
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
}

@end

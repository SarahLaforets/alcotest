//
//  Verre.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 13/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "Verre.h"

@implementation Verre

// Singleton
+ (instancetype)sharedInstance {
    static Verre *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Verre alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

// Insert code here to add functionality to your managed object subclass
- (void)addVerre:(NSString *)name withQuantity:(NSNumber*)quantity {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSManagedObject *verre = [NSEntityDescription insertNewObjectForEntityForName:@"Verre" inManagedObjectContext:context];
    
    [verre setValue:name forKey:@"name"];
    [verre setValue:quantity forKey:@"quantite"];
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
}

- (NSArray *)fetchVerre {
    NSArray *verres;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Verre" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    verres = [context executeFetchRequest:request error:&error];
    
    return verres;
}
@end

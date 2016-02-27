//
//  CalculViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 30/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Drink.h"
#import "Verre.h"
#import "Bar.h"
#import "Taux.h"
#import "Profil.h"

@interface CalculViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *tfTaux;
@property (strong, nonatomic) IBOutlet UIButton *btnCalcul;

@property (strong, nonatomic) Profil *mProfil; 

@end

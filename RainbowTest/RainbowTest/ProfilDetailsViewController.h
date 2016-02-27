//
//  ProfilDetailsViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 31/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profil.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ProfilDetailsViewController : UIViewController
    @property (assign) BOOL testEdit;
    @property (nonatomic, strong) Profil *mProfil;
@property (strong, nonatomic) IBOutlet UITextField *tfName;
@property (strong, nonatomic) IBOutlet UITextField *tfPoids;
@property (strong, nonatomic) IBOutlet UISegmentedControl *SegSexe;


@end

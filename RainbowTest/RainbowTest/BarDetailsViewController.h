//
//  BarDetailsViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 10/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Bar.h"

@interface BarDetailsViewController : UIViewController

    @property (strong, nonatomic) IBOutlet UITextField *tfName;
    @property (strong, nonatomic) IBOutlet UITextField *tfDegree;

    @property (strong, nonatomic) NSString *mName;
    @property (strong, nonatomic) NSNumber *mDegree;
    @property (strong, nonatomic) Bar *theBar;

@end

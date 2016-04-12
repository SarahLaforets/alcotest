//
//  VerreTableViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 07/03/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "VerreDetailsViewController.h"
#import "AppDelegate.h"
#import "Verre.h"
#import "VerreTableViewCell.h"

@interface VerreTableViewController : UITableViewController
@property (nonatomic,strong) Verre *verreDB;
@end

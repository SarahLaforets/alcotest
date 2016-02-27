//
//  EventTableViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 09/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Event.h"
#import "EventDetailsViewController.h"
#import "EventTableViewCell.h"

@interface EventTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tvEvent;
@end

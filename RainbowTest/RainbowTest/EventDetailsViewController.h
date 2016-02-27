//
//  EventDetailsViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 24/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "AddDrinksViewController.h"
#import "DrinksTableViewCell.h"

@interface EventDetailsViewController : UIViewController <AddDrinksViewControllerDelegate>
    @property (strong, nonatomic) IBOutlet UITextField *tfName;
    @property (strong, nonatomic) IBOutlet UITextField *tfDateDebut;
    @property (strong, nonatomic) IBOutlet UITextField *tfDateFin;
    @property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
    @property (strong, nonatomic) IBOutlet UIButton *buttonOK;
    @property (strong, nonatomic) IBOutlet UITableView *tvDrinks;

    @property (assign) BOOL myBoolTest;
    @property (strong, nonatomic) Event *theEvent;


@end

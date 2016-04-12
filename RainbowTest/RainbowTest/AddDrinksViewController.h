//
//  AddDrinksViewController.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 27/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Bar.h"
#import "Verre.h"
#import "Drink.h"
#import "Event.h"

@class AddDrinksViewController;


@protocol AddDrinksViewControllerDelegate <NSObject>
@required
- (void)addItemViewController:(AddDrinksViewController *)controller didFinishEnteringDrink:(Drink *)drink testEdit:(BOOL)test rowAtIndexPath:(NSInteger*)row;
@end

@interface AddDrinksViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *boissonPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *verrePicker;
@property (strong, nonatomic) IBOutlet UITextField *tfBoisson;
@property (strong, nonatomic) IBOutlet UITextField *tfVerre;
@property (strong, nonatomic) IBOutlet UITextField *tfNbeVerre;
@property (strong, nonatomic) IBOutlet UIButton *btnOK;

@property (strong, nonatomic) IBOutlet UITextField *tfTime;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) Drink *drink;
@property (assign) BOOL testEdit;
@property  NSInteger *row;
@property (nonatomic,strong) Verre *verreDB;
@property (nonatomic,strong) Bar *barDB;

@property (nonatomic, weak) id <AddDrinksViewControllerDelegate> delegate;

@end

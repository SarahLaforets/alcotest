//
//  BarDetailsViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 10/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import "BarDetailsViewController.h"


@interface BarDetailsViewController ()
@property (nonatomic, retain) Bar *mBar;

@end

@implementation BarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bar" inManagedObjectContext:context];
    NSPredicate *forName = [NSPredicate predicateWithFormat:@"name = %@", self.theBar.name];
    
    [request setPredicate:forName];
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    _mBar = [results objectAtIndex:0];
    
    self.tfName.text = _mBar.name;
    if (!(_mBar.degre == 0)) {
        NSString *degree = [_mBar.degre stringValue];
        self.tfDegree.text = degree;
    }
    
    self.navigationItem.title = _mBar.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)save:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    //NSManagedObject *bar = [NSEntityDescription insertNewObjectForEntityForName:@"Bar" inManagedObjectContext:context];
    
    if (![_tfName.text isEqualToString:_theBar.name]) {
        [_mBar setValue:_tfName.text forKey:@"name"];
    }
    
    NSNumber  *degree = [NSNumber numberWithInteger: [_tfDegree.text integerValue]];
    
    [_mBar setValue:degree forKey:@"degre"];
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
    [[self navigationController] popViewControllerAnimated:true];
}

@end

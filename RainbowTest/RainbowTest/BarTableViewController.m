//
//  BarTableViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 09/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import "BarTableViewController.h"

@interface BarTableViewController ()
@property (nonatomic, retain) NSArray *bar;
@end

@implementation BarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Lors du premier chargement de l'application
    
    if ([[self fetchAllBar] count] == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Bar" ofType:@"plist"];
        //NSDictionary * = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *allBar = [NSArray arrayWithContentsOfFile:path];
        int id = 0;
        for (NSDictionary *theBar in allBar) {
            NSString *name = theBar[@"name"];
            NSString *degre = theBar[@"degre"];
            [self addBarInDataBase:name withDegre:degre];
            id++;
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    _bar = [self fetchAllBar];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bar.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.labelNom.text = [[self bar][indexPath.row] name];
    cell.labelDegre.text = [NSString stringWithFormat:@"%@ degrés", [[self bar][indexPath.row] degre]];
    
    //cell.ivLogoBoisson.image = [UIImage imageNamed: @"Bottle_100.png"];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"fontCellBar.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    //cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_pressed.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.managedObjectContext;
        
        Bar *barToDelete = [_bar objectAtIndex:indexPath.row];
        
        [context deleteObject:barToDelete];
        
        NSError* error = nil;
        [context save:&error];
        
        NSMutableArray *mutuableBar = [NSMutableArray arrayWithArray:_bar];
        [mutuableBar removeObjectAtIndex:indexPath.row];
        self.bar = [NSArray arrayWithArray:mutuableBar];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"upDateBar"]) {
        BarDetailsViewController *barDetails = (BarDetailsViewController *)[segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        barDetails.mName = [[self bar][path.row] name];
        Bar *mBar = [self bar][path.row];
        barDetails.theBar = mBar;
    }
}

#pragma mark - Action

- (IBAction)addBottleType:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a new bottle"
                                                                  message:@"Name :"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              //Do Some action here
                                                              UITextField *textField = alert.textFields[0];
                                                              NSLog(@"text was %@", textField.text);
                                                              
                                                              AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                                              NSManagedObjectContext* context = appDelegate.managedObjectContext;
                                                              
                                                              NSManagedObject *bar = [NSEntityDescription insertNewObjectForEntityForName:@"Bar" inManagedObjectContext:context];
                                                              
                                                              [bar setValue:textField.text forKey:@"name"];
                                                              //[bar setValue:10 forKey:@"degre"];
                                                              
                                                              NSError *error = nil;
                                                              if(![context save:&error]) {
                                                                  NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
                                                              }
                                                              
                                                              NSFetchRequest *request = [[NSFetchRequest alloc] init];
                                                              NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bar" inManagedObjectContext:context];
                                                              
                                                              [request setEntity:entityDescription];
                                                              _bar = [context executeFetchRequest:request error:&error];
                                                              
                                                              [[self tableView] reloadData];
                                                          }];
    
    [alert addAction:defaultAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Tequila";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    [self presentViewController:alert animated:YES completion:nil];
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

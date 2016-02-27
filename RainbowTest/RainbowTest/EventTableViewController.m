//
//  EventTableViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 09/11/2015.
//  Copyright © 2015 Sarah LAFORETS. All rights reserved.
//

#import "EventTableViewController.h"


@interface EventTableViewController ()
@property (nonatomic, retain) NSArray *event;
@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    _event = [context executeFetchRequest:request error:&error];
    
    [_tvEvent reloadData];
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
    return _event.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellEvent" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.nameEvent.text = [[self event][indexPath.row] name];
    
    //Format pour afficher la date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *stringBegin = [formatter stringFromDate:[[self event][indexPath.row] begin]];
    
    NSString *stringEnd = [formatter stringFromDate:[[self event][indexPath.row] end]];
    
    cell.dateEvent.text = [NSString stringWithFormat:@"Du %@ au %@", stringBegin, stringEnd];
    
    return cell;
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
        
        Event *eventToDelete = [_event objectAtIndex:indexPath.row];
        
        for (Drink *drinks in [eventToDelete refDrink]) {
            [context deleteObject:drinks];
            NSError* error = nil;
            [context save:&error];
        }
        
        [context deleteObject:eventToDelete];
        
        NSError* error = nil;
        [context save:&error];
        
        NSMutableArray *mutuableBar = [NSMutableArray arrayWithArray:_event];
        [mutuableBar removeObjectAtIndex:indexPath.row];
        self.event = [NSArray arrayWithArray:mutuableBar];
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
    
    if ([[segue identifier] isEqualToString:@"addEvent"]) {
        
        NSLog(@"add an event");
        EventDetailsViewController *eventDetailController = (EventDetailsViewController*)[segue destinationViewController];
        
        eventDetailController.myBoolTest = false;
        
    } else if([[segue identifier] isEqualToString:@"showEvent"]) {
        
        NSLog(@"show an event");
        EventDetailsViewController *eventDetailController = (EventDetailsViewController*)[segue destinationViewController];
        
        eventDetailController.myBoolTest = true;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Event *mEvent = [self event][path.row];
        eventDetailController.theEvent = mEvent;
    }
}


@end

//
//  ProfilsTableViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 31/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "ProfilsTableViewController.h"

@interface ProfilsTableViewController ()
@property (nonatomic, retain) NSArray *profils;
@end

@implementation ProfilsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Profil" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    _profils = [context executeFetchRequest:request error:&error];
    
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
    return _profils.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profilCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.UserName.text = [[self profils][indexPath.row] name];
    if ([[[self profils][indexPath.row] sexe] boolValue] == YES) {
        cell.imageView.image = [UIImage imageNamed:@"User_Female_50.png"];
    } else if ([[[self profils][indexPath.row] sexe] boolValue] == NO) {
        cell.imageView.image = [UIImage imageNamed:@"User_Male_50.png"];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    if ([[segue identifier] isEqualToString:@"AddProfil"]) {
        
        NSLog(@"add a profil");
        ProfilDetailsViewController *profilDetailController = (ProfilDetailsViewController*)[segue destinationViewController];
        
        profilDetailController.testEdit = false;
        
    } else if ([[segue identifier] isEqualToString:@"EditProfil"]) {
        ProfilDetailsViewController *profilDetailController = (ProfilDetailsViewController*)[segue destinationViewController];
        Profil *mProfil = [self profils][path.row];
        profilDetailController.testEdit = true;
        profilDetailController.mProfil = mProfil;
        
    } else if ([[segue identifier] isEqualToString:@"calculTaux"]) {
        Profil *mProfil = [self profils][path.row];
        CalculViewController *calculViewController = (CalculViewController*)[segue destinationViewController];
        calculViewController.mProfil = mProfil;
    }
}


@end

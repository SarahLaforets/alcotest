//
//  GestionTableViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 01/03/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "GestionTableViewController.h"

@interface GestionTableViewController ()
@property (nonatomic, retain) NSMutableArray *gestion;
@end

@implementation GestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _gestion = [[NSMutableArray alloc] init];
    [_gestion addObject:@"Bar"];
    [_gestion addObject:@"Cocktails"];
    [_gestion addObject:@"Verres"];

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

    return _gestion.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gestionCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.labelGestion.text = [_gestion objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"Wine_50.png"];
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"Cocktail_50.png"];
    } else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"Wine_Glass_50.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    BarTableViewController *barTableViewController = (BarTableViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"BarTableViewController"];
    
    if (indexPath.row == 0) {
        [[self navigationController] pushViewController:barTableViewController animated:true];
    } /*else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"Cocktail_50.png"];
    } else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"Wine_Glass_50.png"];
    }*/
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  EventDetailsViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 24/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@property (nonatomic, retain) UITextField *textFieldActif;
@property (nonatomic, retain) NSDate *debut;
@property (nonatomic, retain) NSDate *fin;
@property (nonatomic, retain) NSMutableArray *drinks;


@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // On test si on vient ajouter un nouvel Event ou non
    // False si c'est un nouvel ajout
    // True si c'est afficher les details
    _drinks = [[NSMutableArray alloc] init];
    if (_myBoolTest == true) {
        //Affiche le nom de l'event
        _tfName.text = _theEvent.name;
        
        //Format pour afficher la date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
        
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        NSString *stringBegin = [formatter stringFromDate:[_theEvent begin]];
        _tfDateDebut.text = stringBegin;
        _debut = [_theEvent begin];
        
        NSString *stringEnd = [formatter stringFromDate:[_theEvent end]];
        _tfDateFin.text = stringEnd;
        _fin = [_theEvent end];
        
        
        //Init du tableau de boisson
        for (Drink *mDrink in [_theEvent refDrink]) {
            [_drinks addObject:mDrink];
        }
        
        self.navigationItem.title = _theEvent.name;
    }
    

    //[_tfName becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextfield

//Lors d'un clic dans un textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _textFieldActif = textField;
    
    if (textField == _tfDateDebut || textField == _tfDateFin) {
        // Affichage du date picker
        
        _datePicker.hidden = false;
        _buttonOK.hidden = false;
        _tvDrinks.hidden = true;
        // Cache le clavier
        [self.view endEditing:YES];
        return NO;
    } else if (textField == _tfName) {
        _datePicker.hidden = true;
        _buttonOK.hidden = true;
        _tvDrinks.hidden = false;
        [textField resignFirstResponder];
        return YES;
    } else {
        return YES;
    }
}

//Quand on fini l'édition
- (void)textFieldDidEndEditing:(UITextField*)textField {
    if (textField == _tfDateDebut) {
        _datePicker.hidden = true;
        _buttonOK.hidden = true;
        _tvDrinks.hidden = false;
    } else if (textField == _tfDateFin) {
        _datePicker.hidden = true;
        _buttonOK.hidden = true;
        _tvDrinks.hidden = false;
    } else if (textField == _tfName) {
       
    }
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (IBAction)saveEvent:(id)sender {
    
    NSDate *dateLate = [_debut laterDate:_fin];
    // Si la date de fin n'est pas plus ancienne : Erreur !
    if (![dateLate isEqual:_fin]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Erreur"
                                                                       message:@"La date de fin doit être plus ancienne que la date de début."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action){
                                                                  //Do Some action here
                                                                  
                                                              }];
        
        [alert addAction:defaultAction];

        [self presentViewController:alert animated:YES completion:nil];
    } else {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.managedObjectContext;
        NSManagedObject *event;
        
        if (_myBoolTest == true) {
            event = _theEvent;
        } else {
            event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
            _theEvent = (Event*) event;
        }
        NSSet *drinksSet;
        drinksSet = [[NSSet alloc] initWithArray:_drinks];
        
        [event setValue:_tfName.text forKey:@"name"];
        [event setValue:_debut forKey:@"begin"];
        [event setValue:_fin forKey:@"end"];
        [event setValue:drinksSet forKey:@"refDrink"];
        
        
        NSError *error = nil;
        if(![context save:&error]) {
            NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
        }
        if (_myBoolTest == false) {
            _theEvent = (Event*) event;
            _myBoolTest = true;
        }
        [[self navigationController] popViewControllerAnimated:true];
    }
}

- (IBAction)selectDatePicker:(id)sender {
    _datePicker.hidden = true;
    _buttonOK.hidden = true;
    _tvDrinks.hidden = false;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *stringFromDate = [formatter stringFromDate:[_datePicker date]];
    
    if (_textFieldActif == _tfDateDebut) {
        _tfDateDebut.text = stringFromDate;
        _debut = _datePicker.date;
    } else if (_textFieldActif == _tfDateFin) {
        _tfDateFin.text = stringFromDate;
        _fin = _datePicker.date;
    }
}
- (IBAction)addDrink:(id)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddDrinksViewController *addDrinksViewController = (AddDrinksViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"AddDrinksViewController"];
    addDrinksViewController.delegate = self;
    addDrinksViewController.event = _theEvent;
    addDrinksViewController.testEdit = false;
    
    [[self navigationController] pushViewController:addDrinksViewController animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drinks.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddDrinksViewController *addDrinksViewController = (AddDrinksViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"AddDrinksViewController"];
    addDrinksViewController.delegate = self;
    addDrinksViewController.event = _theEvent;
    addDrinksViewController.drink = [self drinks][indexPath.row];
    addDrinksViewController.testEdit =true;
    addDrinksViewController.row = [indexPath row];
    
    [[self navigationController] pushViewController:addDrinksViewController animated:true];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrinksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellEvent" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    //NSString *stringFromDate = [formatter stringFromDate:[[self drinks][indexPath.row] time]];
    //cell.textLabel.text = stringFromDate;
    
    
    NSString *verre = [[[self drinks][indexPath.row] refVerre] name];
    
    NSString *nombre = [[self drinks][indexPath.row] nombre];
    
    NSString *bar = [[[self drinks][indexPath.row] refBar] name];
    
    cell.nomBoisson.text = bar;
    cell.nombreBoisson.text = [NSString stringWithFormat: @"%@ %@", nombre, verre];
    
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
        
        Drink *drinkToDelete = [_drinks objectAtIndex:indexPath.row];
       
        [context deleteObject:drinkToDelete];
        
        NSError* error = nil;
        [context save:&error];
        
        [_drinks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)addItemViewController:(AddDrinksViewController *)controller didFinishEnteringDrink:(Drink *)item  testEdit:(BOOL)test rowAtIndexPath:(NSInteger *)row{
    //NSLog(@"This was returned from ViewControllerB %@",item);
    if (test == false) {
        [_drinks addObject:item];
        [[self tvDrinks] reloadData];
    } else {
        [_drinks removeObjectAtIndex:row];
        [_drinks  insertObject:item atIndex:row];
        [[self tvDrinks] reloadData];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

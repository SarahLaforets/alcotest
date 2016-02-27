//
//  AddDrinksViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 27/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "AddDrinksViewController.h"


@interface AddDrinksViewController ()
    @property (nonatomic, retain) UITextField *textFieldActif;
    @property (nonatomic, retain) Bar *myBar;
    @property (nonatomic, retain) Verre *myVerre;
    @property (nonatomic, retain) NSDate *myDate;
@end

@implementation AddDrinksViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_testEdit == true) {
        _tfBoisson.text = [[_drink refBar] name];
        _tfNbeVerre.text = [NSString stringWithFormat: @"%@", [_drink nombre]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
        
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        NSString *stringFromDate = [formatter stringFromDate:[_drink time]];
        _tfTime.text = stringFromDate;
        _tfVerre.text = [[_drink refVerre] name];
    }
    // Do any additional setup after loading the view.
    if ([[self fetchVerre] count] == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Verres" ofType:@"plist"];
        //NSDictionary * = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *allBar = [NSArray arrayWithContentsOfFile:path];
        int id = 0;
        for (NSDictionary *theBar in allBar) {
            NSString *name = theBar[@"name"];
            NSNumber  *quantite = [NSNumber numberWithInteger:[theBar[@"quantite"] integerValue]];
            [self addVerre:name withQuantity:quantite];
            id++;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextfield

//Lors d'un clic dans un textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _textFieldActif = textField;
    
    if (textField == _tfBoisson) {
        // Affichage du date picker
        _verrePicker.hidden = true;
        _datePicker.hidden = true;
        _boissonPicker.hidden = false;
        _btnOK.hidden = false;
        // Cache le clavier
        [self.view endEditing:YES];
        return NO;
    } else if (textField == _tfVerre) {
        // Affichage du date picker
        _boissonPicker.hidden = true;
        _datePicker.hidden = true;
        _verrePicker.hidden = false;
        _btnOK.hidden = false;
        // Cache le clavier
        [self.view endEditing:YES];
        return NO;
    } else if (textField == _tfTime) {
        // Affichage du date picker
        _boissonPicker.hidden = true;
        _verrePicker.hidden = true;
        _datePicker.hidden = false;
        _btnOK.hidden = false;
        // Cache le clavier
        [self.view endEditing:YES];
        return NO;
    } else if (textField == _tfNbeVerre) {
        _boissonPicker.hidden = true;
        _verrePicker.hidden = true;
        _btnOK.hidden = true;
        [textField resignFirstResponder];
        return YES;
    } else {
        return YES;
    }
}

//Quand on fini l'édition
- (void)textFieldDidEndEditing:(UITextField*)textField {
    if (textField == _tfBoisson) {
        _boissonPicker.hidden = true;
        _btnOK.hidden = true;
    } else if (textField == _tfVerre) {
        _verrePicker.hidden = true;
        _btnOK.hidden = true;
    } else if (textField == _tfTime) {
        _datePicker.hidden = true;
        _btnOK.hidden = true;
    }
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - DataSource Picker

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
   
    if (pickerView.tag == 20) {
        return [[self fetchBoisson] count];
    } else if (pickerView.tag == 10) {
        return [[self fetchVerre] count];
    } else {
        return 0;
    }
}

#pragma mark - Delegate Picker

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component {
    if (pickerView.tag == 20) {
        return [[[self fetchBoisson] objectAtIndex:row] name];
    } else if (pickerView.tag == 10) {
        return [NSString stringWithFormat:@"%@ %@ cL", [[[self fetchVerre] objectAtIndex:row] name], [[[self fetchVerre] objectAtIndex:row] quantite]];
    } else {
        return @"null";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component {
    if (pickerView.tag == 20) {
        _tfBoisson.text = [[[self fetchBoisson] objectAtIndex:row] name];
        _myBar = (Bar *) [[self fetchBoisson] objectAtIndex:row];
    } else if (pickerView.tag == 10) {
        _tfVerre.text = [[[self fetchVerre] objectAtIndex:row] name];
        _myVerre = (Verre *) [[self fetchVerre] objectAtIndex:row];
    }
}

#pragma mark - Core Data

- (NSArray *)fetchBoisson {
    NSArray *boissons;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bar" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    boissons = [context executeFetchRequest:request error:&error];
    
    return boissons;
}

- (NSArray *)fetchVerre {
    NSArray *verres;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Verre" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    NSError *error = nil;
    verres = [context executeFetchRequest:request error:&error];
    
    return verres;
}

- (void)addVerre:(NSString *)name withQuantity:(NSNumber*)quantity {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSManagedObject *verre = [NSEntityDescription insertNewObjectForEntityForName:@"Verre" inManagedObjectContext:context];
    
    [verre setValue:name forKey:@"name"];
    [verre setValue:quantity forKey:@"quantite"];
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
}

#pragma mark - Actions

- (IBAction)btnOK:(id)sender {
    _boissonPicker.hidden = true;
    _verrePicker.hidden = true;
    _datePicker.hidden = true;
    _btnOK.hidden = true;
    
    if (_textFieldActif == _tfTime) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd'-'MM'-'yyyy' 'HH':'mm'"];
        
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        NSString *stringFromDate = [formatter stringFromDate:[_datePicker date]];
        _tfTime.text = stringFromDate;
        _myDate = [_datePicker date];
    }
}

- (IBAction)saveDrink:(id)sender {
    
    // Controle pour la date de prise comprise dans les dates de l'event
    if (([_myDate compare:[_event begin]] == NSOrderedDescending) && ([_myDate compare:[_event end]] == NSOrderedAscending)) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.managedObjectContext;
        
        NSManagedObject *drink;
        
        if (_testEdit == true) {
            drink = _drink;
        } else {
            drink = [NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:context];
        }
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [f numberFromString:_tfNbeVerre.text];
        
        [drink setValue:_myBar forKey:@"refBar"];
        [drink setValue:_myVerre forKey:@"refVerre"];
        [drink setValue:myNumber forKey:@"nombre"];
        [drink setValue:_myDate forKey:@"time"];
        
        NSError *error = nil;
        if(![context save:&error]) {
            NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
        }
        
        [self.delegate addItemViewController:self didFinishEnteringDrink:(Drink*)drink testEdit:_testEdit rowAtIndexPath:_row];
        [[self navigationController] popViewControllerAnimated:true];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Erreur"
                                                                       message:@"La date de prise doit être comprise entre la date de début et de fin de l'event."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action){
                                                                  //Do Some action here
                                                                  
                                                              }];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
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

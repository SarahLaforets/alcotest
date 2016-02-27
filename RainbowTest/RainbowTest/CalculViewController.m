//
//  CalculViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 30/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "CalculViewController.h"

@interface CalculViewController ()
@property double taux;
@end

@implementation CalculViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tfTaux.text = @"";
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

#pragma mark - Action
- (IBAction)calculTaux:(id)sender {
    NSArray *drinks = [self fetchAllDrinks];
    _taux = 0.0;
    for (Drink *drink in drinks) {
        double tauxEffemere;
        double volumeML = ([([[drink refVerre] quantite]) intValue]*10) * [[drink nombre] intValue];
        double degree = [[[drink refBar] degre] intValue];
        double coef = 0.0;
        if ([[[self mProfil] sexe] boolValue] == YES) {
            coef = 0.6;
        } else if ([[[self mProfil] sexe] boolValue] == NO) {
            coef = 0.7;
        }
        
        double masseKG = [[[self mProfil] poids] intValue];
        tauxEffemere = ((volumeML*(degree/100)*0.8) / (coef*masseKG));
        
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
        NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        NSDateComponents *conversionInfo = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[drink time]   toDate:today  options:0];
        
        //double months = [conversionInfo month];
        //double days = [conversionInfo day];
        double hours = [conversionInfo hour];
        double minutes = [conversionInfo minute];
        
        NSLog(@"Les drinks différence: %f : %f", hours, minutes);
        
        while (hours >= 1) {
            hours = hours - 1;
            tauxEffemere = tauxEffemere - 0.15;
            if (tauxEffemere < 0) {
                tauxEffemere = 0;
            }
        }
        
        _taux = tauxEffemere + _taux;
    }
    _tfTaux.text = [NSString stringWithFormat:@"%f g/L de sang", _taux];
}

- (NSArray*)fetchAllDrinks {
    NSArray *drinks;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Drink" inManagedObjectContext:context];
    //NSCalendarcurrentCalendar *calendar;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
    [components setHour:components.hour-24]; //
    NSDate *hourback = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSLog(@"HourBack : %@", hourback);
    NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"time <= %@ && time > %@", today, hourback];
    //[subpredicates addObject:subPredTo];
    
    //NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"time < %@", hourback];
    //[subpredicates addObject:subPredFrom];
    [request setPredicate:subPredFrom];
    //[request setPredicate:subPredTo];
    [request setEntity:entityDescription];
    NSError *error = nil;
    drinks = [context executeFetchRequest:request error:&error];
    
    return drinks;
}
- (IBAction)SaveTaux:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSManagedObject *taux = [NSEntityDescription insertNewObjectForEntityForName:@"Taux" inManagedObjectContext:context];
    
    [taux setValue:[NSNumber numberWithDouble:_taux] forKey:@"taux"];
    [taux setValue:_mProfil forKey:@"refProfil"];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    [taux setValue:today forKey:@"moment"];
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
}

@end

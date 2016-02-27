//
//  ProfilDetailsViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 31/01/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "ProfilDetailsViewController.h"

@interface ProfilDetailsViewController ()

@end

@implementation ProfilDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_testEdit == true) {
        _tfName.text = [[self mProfil] name];
        _tfPoids.text = [NSString stringWithFormat:@"%@", [[self mProfil] poids]] ;
        if ([[[self mProfil] sexe] boolValue] == YES) {
            _SegSexe.selectedSegmentIndex = 1;
        } else if ([[[self mProfil] sexe] boolValue] == NO) {
            _SegSexe.selectedSegmentIndex = 0;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)saveProfil:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    NSManagedObject *profil;
    
    if (_testEdit == true) {
        profil = _mProfil;
    } else {
        profil = [NSEntityDescription insertNewObjectForEntityForName:@"Profil" inManagedObjectContext:context];
        //_mProfil = (Profil*) ;
    }
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *poids = [f numberFromString:_tfPoids.text];
    
    [profil setValue:_tfName.text forKey:@"name"];
    [profil setValue:poids forKey:@"poids"];
    if ([[_SegSexe titleForSegmentAtIndex:_SegSexe.selectedSegmentIndex] isEqualToString:@"Homme"]) {
        [profil setValue:[NSNumber numberWithBool:NO] forKey:@"sexe"];
    } else if ([[_SegSexe titleForSegmentAtIndex:_SegSexe.selectedSegmentIndex] isEqualToString:@"Femme"]){
        [profil setValue:[NSNumber numberWithBool:YES] forKey:@"sexe"];
    }
    
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"Problème lors de la sauvegarde : %@", [error localizedDescription]);
    }
    [[self navigationController] popViewControllerAnimated:true];
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

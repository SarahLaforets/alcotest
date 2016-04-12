//
//  VerreDetailsViewController.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 07/03/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VerreDetailsViewController.h"

@interface VerreDetailsViewController ()
    
@end

@implementation VerreDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveVerre:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveVerre:(id)sender {
    
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

//
//  BarTableViewCell.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 05/02/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ivLogoBoisson;
@property (strong, nonatomic) IBOutlet UILabel *labelNom;
@property (strong, nonatomic) IBOutlet UILabel *labelDegre;

@end

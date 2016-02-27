//
//  BarTableViewCell.m
//  RainbowTest
//
//  Created by Sarah LAFORETS on 05/02/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "BarTableViewCell.h"

@implementation BarTableViewCell

@synthesize ivLogoBoisson = _ivLogoBoisson;
@synthesize labelDegre = _labelDegre;
@synthesize labelNom = _labelNom;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  EventTableViewCell.h
//  RainbowTest
//
//  Created by Sarah LAFORETS on 11/02/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameEvent;
@property (strong, nonatomic) IBOutlet UILabel *dateEvent;

@end

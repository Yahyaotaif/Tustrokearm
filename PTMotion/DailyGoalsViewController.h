//
//  DailyGoalsViewController.h
//  ARMStrokes
//
//  Created by Ted Smith on 4/19/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DailyGoalsViewController : UITableViewController
@property (nonatomic, strong) NSData *data;
+ (BOOL)isFirstTime;

@end
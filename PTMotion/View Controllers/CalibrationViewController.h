//
//  CalibrationViewController.h
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalibrationViewController : UITableViewController
@property (nonatomic,strong) NSUserDefaults *caliDefault;
@property (nonatomic, strong) NSData *data;
+ (BOOL)isFirstTime;
+(int)roundUp:(NSNumber *) x;
@end

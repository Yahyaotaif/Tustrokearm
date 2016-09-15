//
//  SessionResultsViewController.h
//  MotionTraking
//
//  Created by David Messing on 3/16/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTSession;

@interface PTSessionResultsViewController : UITableViewController

@property (nonatomic, strong) PTSession* session;

@end

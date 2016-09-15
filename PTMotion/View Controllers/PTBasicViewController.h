//
//  PTBasicViewController.h
//  PTMotion
//
//  Created by David Messing on 10/27/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTViewController.h"

@interface PTBasicViewController : PTViewController

@property (nonatomic, weak, readonly) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readonly) IBOutlet UILabel *timerLabel;

- (void)updateTimerLabel:(NSString *)text;
- (void)updateScoreLabel:(NSString *)text;

- (void)presentSessionResults;

@end
//
//  FigureView.m
//  MotionTraking
//
//  Created by David Messing on 2/11/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "AstronautView.h"

@interface AstronautView ()

@property (nonatomic, weak, readwrite) IBOutlet UIImageView *flameImageView;

@end

@implementation AstronautView

- (void)liftoff:(BOOL)accelerate
{
    if (accelerate) {
        self.flameImageView.hidden = NO;
    } else {
        self.flameImageView.hidden = YES;
    }
}

@end

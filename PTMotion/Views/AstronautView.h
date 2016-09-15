//
//  FigureView.h
//  MotionTraking
//
//  Created by David Messing on 2/11/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "FigureView.h"

@interface AstronautView : FigureView

@property (nonatomic, weak, readonly) IBOutlet UIImageView *flameImageView;

- (void)liftoff:(BOOL)accelerate;

@end

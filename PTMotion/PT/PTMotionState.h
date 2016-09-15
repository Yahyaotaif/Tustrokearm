//
//  MotionState.h
//  MotionTraking
//
//  Created by David Messing on 2/10/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreMotion;
@import CoreGraphics;

@class PTMotionStateContext;

@interface PTMotionState : NSObject

@property (nonatomic, strong) PTMotionStateContext *context;

- (id)initWithContext:(PTMotionStateContext *)context;
- (void)update:(CMDeviceMotion *)motion;

@end

// Vertical

@interface StateBegin : PTMotionState

@end

@interface StateUp : PTMotionState

@end

@interface StateDown : PTMotionState

@end

// Rotation

@interface StateFaceUp : PTMotionState

@end

@interface StateFaceDown : PTMotionState

@end

// Flexion

@interface StateFlexionLowered : PTMotionState

@end

@interface StateFlexionRaised : PTMotionState

@end

// Abduction (Rotation)

@interface StateAbductionRaised : PTMotionState

@end

@interface StateAbductionLowered : PTMotionState




@end

//Elbow Flexion
@interface ElbowStateFlexionLowered : PTMotionState

@end

@interface ElbowStateFlexionRaised : PTMotionState

@end

//Shoulder Abduct
@interface ShoulderAbductStateLowered : PTMotionState

@end

@interface ShoulderAbductStateRaised : PTMotionState

@end

//Horizontal Shoulder Rotation
@interface HorizShoulderStateLowered : PTMotionState

@end

@interface HorizShoulderStateRaised : PTMotionState

@end





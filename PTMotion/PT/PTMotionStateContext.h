//
//  MotionStateContext.h
//  MotionTraking
//
//  Created by David Messing on 2/11/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreMotion;
@import CoreGraphics;

@class PTMotionState;
@class PTMotionStateContext;

@protocol PTMotionStateContextDelegate <NSObject>

@optional
- (void)motionStateContext:(PTMotionStateContext*)context willTransitionFromState:(PTMotionState *)oldState toState:(PTMotionState *)newState; // arrives on main queue
- (void)motionStateContext:(PTMotionStateContext*)context didChangeState:(PTMotionState *)state; // arrives on main queue
@end

typedef NS_ENUM(NSUInteger, MotionStateUpdateType) {
    MotionStateUpdateVerticalMotion,
    MotionStateUpdateSupination,
    MotionStateUpdatePronation,
    MotionStateUpdateFlexion,
    MotionStateUpdateShoulderAbduction,
    MotionStateUpdateElbowFlexion,
    MotionStateUpdateHoriz,
    MotionStateAbduction2,
    MotionStateUpdateUndefined
};

@interface PTMotionStateContext : NSObject

@property (nonatomic, readonly, readonly) MotionStateUpdateType type;
@property (nonatomic, weak) id<PTMotionStateContextDelegate> delegate;
@property (nonatomic, strong) PTMotionState *state;

@property (nonatomic, strong, readonly) CMMotionManager *motionManager; // for reading current values

@property CGFloat verticalUpperThreshhold;
@property CGFloat verticalLowerThreshhold;

@property CGFloat faceDownRollValue;
@property CGFloat faceUpRollValue;
@property CGFloat rollThreshold;

@property CGFloat flexionLoweredValue;
@property CGFloat flexionRaisedValue;
@property CGFloat flexionThreshold;

@property CGFloat abductionLoweredValue;
@property CGFloat abductionRaisedValue;
@property CGFloat abductionThreshold;

//New Addition
@property CGFloat elbowFlexionLoweredValue;
@property CGFloat elbowFlexionRaisedValue;
@property CGFloat elbowFlexionThreshold;

//New Addition
@property CGFloat shoulderAbductLoweredValue;
@property CGFloat shoulderAbductRaisedValue;
@property CGFloat shoulderAbductThreshold;

//New Addition
@property CGFloat horizShoulderLoweredValue;
@property CGFloat horizShoulderRaisedValue;
@property CGFloat horizShoulderThreshold;

- (void)startDeviceMotionUpdatesForType:(MotionStateUpdateType)type;
- (void)startDeviceMotionUpdates DEPRECATED_ATTRIBUTE;
- (void)stopDeviceMotionUpdates;

@end

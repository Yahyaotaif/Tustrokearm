//
//  Session.h
//  MotionTraking
//
//  Created by David Messing on 3/16/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTConstants.h"

typedef NS_ENUM(NSUInteger, PTSessionState) {
    PTSessionStateInactive,
    PTSessionStateActive,
    PTSessionStateEnded
};

@protocol PTSessionDelegate;

@interface PTSession : NSObject

@property (readonly, nonatomic) PTSessionState state;
@property (nonatomic, assign) id<PTSessionDelegate> delegate;

@property (readonly) NSTimeInterval sessionTime;
@property (readonly, nonatomic) NSTimeInterval countdownTimeRemaining;
@property (readonly, nonatomic) NSTimeInterval sessionTimeRemaining;
@property (readonly, nonatomic) NSUInteger actionCount;

@property (nonatomic, copy, readonly) NSDate *startTime;
@property (nonatomic, copy, readonly) NSDate *endTime;

@property (nonatomic) PTExercise exercise;
@property (nonatomic) PTHand hand;

- (instancetype)initWithSessionTime:(NSTimeInterval)sessionTime;
- (void)startSession;
- (void)endSession;

- (void)incrementActionCount;

- (NSArray *)dataPoints;
- (void)addDataPoint:(NSNumber *)dataPoint;

@end

@protocol PTSessionDelegate <NSObject>

@optional
- (void)sessionStateDidChange:(PTSession*)context;
- (void)sessionCountdownTimeDidChange:(PTSession*)context;
- (void)sessionSessionTimeDidChange:(PTSession*)context;
- (void)sessionActionCountDidChange:(PTSession*)context;

@end
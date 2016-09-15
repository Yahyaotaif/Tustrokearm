//
//  Session.m
//  MotionTraking
//
//  Created by David Messing on 3/16/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTSession.h"

static NSTimeInterval const DefaultCountdownTime = 5;
static NSTimeInterval const DefaultSessionTime = 60;

@interface PTSession ()

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, strong) NSTimer *sessionTimer;

@property (readwrite, nonatomic) PTSessionState state;

@property (readwrite) NSTimeInterval sessionTime;
@property (readwrite, nonatomic) NSTimeInterval countdownTimeRemaining;
@property (readwrite, nonatomic) NSTimeInterval sessionTimeRemaining;

@property (readwrite, nonatomic) NSUInteger actionCount;
@property (nonatomic, strong) NSMutableArray *dataPointsArray;

@property (nonatomic, copy, readwrite) NSDate *startTime;
@property (nonatomic, copy, readwrite) NSDate *endTime;

@end

@implementation PTSession

#pragma mark - Initialization

- (instancetype)initWithSessionTime:(NSTimeInterval)sessionTime
{
    self = [super init];
    if (self) {
        _state = PTSessionStateInactive;
        _sessionTime = sessionTime;
        _sessionTimeRemaining = _sessionTime;
        _countdownTimeRemaining = DefaultCountdownTime;
        _actionCount = 0;
        
        _dataPointsArray = [NSMutableArray array];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithSessionTime:DefaultSessionTime];
}

- (void)dealloc
{
    self.countdownTimer = nil;
    self.sessionTimer = nil;
}

#pragma mark - Property overrides

- (void)setState:(PTSessionState)state
{
    if (_state != state) {
        _state = state;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(sessionStateDidChange:)]) {
            [self.delegate sessionStateDidChange:self];
        }
    }
}

- (void)setCountdownTimeRemaining:(NSTimeInterval)countdownTimeRemaining
{
    if (_countdownTimeRemaining != countdownTimeRemaining) {
        _countdownTimeRemaining = countdownTimeRemaining;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(sessionCountdownTimeDidChange:)]) {
            [self.delegate sessionCountdownTimeDidChange:self];
        }
    }
}

- (void)setSessionTimeRemaining:(NSTimeInterval)sessionTimeRemaining
{
    if (_sessionTimeRemaining != sessionTimeRemaining) {
        _sessionTimeRemaining = sessionTimeRemaining;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(sessionSessionTimeDidChange:)]) {
            [self.delegate sessionSessionTimeDidChange:self];
        }
    }
}

- (void)setActionCount:(NSUInteger)actionCount
{
    if (_actionCount != actionCount) {
        _actionCount = actionCount;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(sessionActionCountDidChange:)]) {
            [self.delegate sessionActionCountDidChange:self];
        }
    }
}

#pragma mark - Session

- (void)startSession
{
    [self intiateSessionCountdown];
}

- (void)intiateSessionCountdown
{
    self.countdownTimeRemaining = DefaultCountdownTime;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTimerFired:) userInfo:nil repeats:YES];
}

- (void)endSessionCountdown
{
    [self.countdownTimer invalidate];
    
    [self intiateSession];
}

- (void)intiateSession
{
    self.state = PTSessionStateActive;
    
    self.sessionTimer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(sessionTimerFired:) userInfo:nil repeats:YES];
    
    self.startTime = [NSDate date];
}

- (void)endSession
{
    self.state = PTSessionStateEnded;
    
    [self.sessionTimer invalidate];
    
    self.endTime = [NSDate date];
}

- (void)countdownTimerFired:(NSTimer *)timer
{
    
    if (self.countdownTimeRemaining > 0) {
        self.countdownTimeRemaining -= 1;
    } else {
        [self endSessionCountdown];
    }
}

- (void)sessionTimerFired:(NSTimer *)timer
{
    if (self.sessionTimeRemaining > 0) {
        self.sessionTimeRemaining -= .2;
    } else {
        [self endSession];
    }
}

#pragma mark - Data

- (void)incrementActionCount
{
    self.actionCount += 1;
}

- (NSArray *)dataPoints
{
    return [NSArray arrayWithArray:self.dataPointsArray];
}

- (void)addDataPoint:(NSNumber *)dataPoint
{
    [self.dataPointsArray addObject:dataPoint];
}

@end

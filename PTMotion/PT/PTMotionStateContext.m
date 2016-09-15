//
//  MotionStateContext.m
//  MotionTraking
//
//  Created by David Messing on 2/11/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTMotionStateContext.h"
#import "PTMotionState.h"
// Note added by Ted, This class has the set up for the patient's movement data
// Default thresholds
static CGFloat const kDefaultVerticalUpperThreshold = 0.2f;
static CGFloat const kDefaultVerticalLowerThreshold = -0.2f;

static CGFloat const kDefaultFaceDownRollValue      = 180.0f;
static CGFloat const kDefaultFaceUpRollValue        = 0.0f;
static CGFloat const kDefaultRollThreshold          = 10.0f;

static CGFloat const kDefaultFlexionLoweredValue    = 0.0f;
static CGFloat const kDefaultFlexionRaisedValue     = 90.0f;
static CGFloat const kDefaultFlexionThreshold       = 10.0f;

static CGFloat const kDefaultAbductionLoweredValue  = 0.0f;
static CGFloat const kDefaultAbductionRaisedValue   = 90.0f;
static CGFloat const kDefaultAbductionThreshold     = 10.0f;


@interface PTMotionStateContext ()

@property (nonatomic, strong) NSOperationQueue *opQueue;

@property (nonatomic, strong, readwrite) CMMotionManager *motionManager;
@property (nonatomic, readwrite) MotionStateUpdateType type;

@end

@implementation PTMotionStateContext

+ (BOOL)isFirstTime{
    static BOOL flag=NO;
    static BOOL result;
    if(!flag){
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunchedOnce"])
        {
            result=NO;
        }
        else
        {   //If it's the first time being launched, it sets the defaults to the default angle measurements
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            result=YES;
            [[NSUserDefaults standardUserDefaults] setFloat: 5 forKey:@"vertUpSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: -5 forKey:@"vertLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceDownSlide"];//Pro Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceUpSlide"];// Sup Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"rollThreshSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"flexLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"flexRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"flexThreshSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 60 forKey:@"abductRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductThreshSlide"];
            //New Addition
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"elbowFlexLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"elbowFlexRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"elbowFlexThreshSlide"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"horizRotateLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"horizRotateRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"horizRotateRangeSlide"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"shouldAbductLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"shouldAbductRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"shouldAbductRangeSlide"];
             NSLog(@"The first time running is PTMotionState");
           
            
            //Changes to save for second hand
            [[NSUserDefaults standardUserDefaults] setFloat: 5 forKey:@"vertUpSlide2"];
            //[[NSUserDefaults standardUserDefaults] setFloat: -5 forKey:@"vertLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceDownSlide2"];//Pro Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceUpSlide2"];// Sup Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"rollThreshSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"flexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"flexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"flexThreshSlide2"];
            
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 60 forKey:@"abductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductThreshSlide2"];
            //New Addition
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"elbowFlexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"elbowFlexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"elbowFlexThreshSlide2"];
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"horizRotateLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"horizRotateRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"horizRotateRangeSlide2"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"shouldAbductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"shouldAbductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"shouldAbductRangeSlide2"];
            //Hand choice
            [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"hand"];
        }
        
        flag=YES;
    }
    return result;}

- (id)init
{
    self = [super init];
    /*
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"vertLowSlide"] == nil){
    if (self) {
        self.opQueue = [[NSOperationQueue alloc] init];
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        
        self.verticalUpperThreshhold = kDefaultVerticalUpperThreshold;
        self.verticalLowerThreshhold = kDefaultVerticalLowerThreshold;
        
        self.faceDownRollValue = kDefaultFaceDownRollValue;
        self.faceUpRollValue = kDefaultFaceUpRollValue;
        self.rollThreshold = kDefaultRollThreshold;
        
        self.flexionLoweredValue = kDefaultFlexionLoweredValue;
        self.flexionRaisedValue = kDefaultFlexionRaisedValue;
        self.flexionThreshold = kDefaultFlexionThreshold;
        
        self.abductionLoweredValue = kDefaultAbductionLoweredValue;
        self.abductionRaisedValue = kDefaultAbductionRaisedValue;
        self.abductionThreshold = kDefaultAbductionThreshold;
        NSLog(@"The if ran!");
    }
  }
    else{
    self.verticalLowerThreshhold = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
    self.verticalUpperThreshhold = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
    
    self.faceDownRollValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
    self.faceUpRollValue = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
    self.rollThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
    
    self.flexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
    self.flexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
    self.flexionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
    
    self.abductionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
    self.abductionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
    self.abductionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
        NSLog(@"The else ran");
    }*/
    
    if([PTMotionStateContext isFirstTime]){
    //This code updates the motion context so the slider syncs up with settings saved.
    if (self) {
        if([[NSUserDefaults standardUserDefaults] floatForKey:@"playingHand"]==0){
            NSLog(@"Values were assigned for playing hand 0, yes with value",[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"]);
            self.opQueue = [[NSOperationQueue alloc] init];
            self.motionManager = [[CMMotionManager alloc] init];
            self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
            
            self.verticalUpperThreshhold = .04*[[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
            self.verticalLowerThreshhold = -1* self.verticalUpperThreshhold;
            
            self.faceDownRollValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
            self.faceUpRollValue = 90-[[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
            self.rollThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
            
            self.flexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
            self.flexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
            self.flexionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
            
            self.abductionLoweredValue = 90-[[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
            self.abductionRaisedValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
            self.abductionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
            //New addition
            self.elbowFlexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
            self.elbowFlexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
            self.elbowFlexionThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
            
            self.horizShoulderLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
            self.horizShoulderRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
            self.horizShoulderThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
            
            self.shoulderAbductLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
            self.shoulderAbductRaisedValue= [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
            self.shoulderAbductThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];
        }
        else{
            self.opQueue = [[NSOperationQueue alloc] init];
            self.motionManager = [[CMMotionManager alloc] init];
            self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
            NSLog(@"Values were assigned for playing hand 1, yes with value ",[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"]);
            self.verticalUpperThreshhold = .04*[[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
            self.verticalLowerThreshhold = -1* self.verticalUpperThreshhold;
            
            self.faceDownRollValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
            self.faceUpRollValue = 90-[[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
            self.rollThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
            
            self.flexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
            self.flexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
            self.flexionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
            
            self.abductionLoweredValue = 90-[[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
            self.abductionRaisedValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
            self.abductionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
            //New addition
            self.elbowFlexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
            self.elbowFlexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
            self.elbowFlexionThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];            }
        
        self.horizShoulderLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
        self.horizShoulderRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
        self.horizShoulderThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
        
        self.shoulderAbductLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
        self.shoulderAbductRaisedValue= [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
        self.shoulderAbductThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];
        
        NSLog(@"The only if ran, %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"]);
        
    }

    
    }
    else{
        if (self) {
            if([[NSUserDefaults standardUserDefaults] floatForKey:@"playingHand"]==0){
                NSLog(@"Values were assigned for playing hand 0, no with value %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"]);
                self.opQueue = [[NSOperationQueue alloc] init];
            self.motionManager = [[CMMotionManager alloc] init];
            self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
           
            self.verticalUpperThreshhold = .04*[[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
            self.verticalLowerThreshhold = -1* self.verticalUpperThreshhold;
            
            self.faceDownRollValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
            self.faceUpRollValue = 90-[[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
            self.rollThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
            
            self.flexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
            self.flexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
            self.flexionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
            
            self.abductionLoweredValue = 90-[[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
            self.abductionRaisedValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
            self.abductionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
            //New addition
            self.elbowFlexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
            self.elbowFlexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
            self.elbowFlexionThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
                
                self.horizShoulderLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
                self.horizShoulderRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
                self.horizShoulderThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
                
                self.shoulderAbductLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
                self.shoulderAbductRaisedValue= [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
                self.shoulderAbductThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];
            }
            else{
                self.opQueue = [[NSOperationQueue alloc] init];
                self.motionManager = [[CMMotionManager alloc] init];
                self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
                NSLog(@"Values were assigned for playing hand 1, no with value %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"]);
                self.verticalUpperThreshhold = .04*[[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
                self.verticalLowerThreshhold = -1* self.verticalUpperThreshhold;
                
                self.faceDownRollValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
                self.faceUpRollValue = 90-[[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
                self.rollThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
                
                self.flexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
                self.flexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
                self.flexionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
                
                self.abductionLoweredValue = 90-[[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
                self.abductionRaisedValue = 90+[[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
                self.abductionThreshold = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
                //New addition
                self.elbowFlexionLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
                self.elbowFlexionRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
                self.elbowFlexionThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
            
                self.horizShoulderLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
                self.horizShoulderRaisedValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
                self.horizShoulderThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
                
                self.shoulderAbductLoweredValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
                self.shoulderAbductRaisedValue= [[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
                self.shoulderAbductThreshold =[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];
            
            }

            NSLog(@"The only if ran, %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"]);
            
        }

    }

    return self;
}

- (void)startDeviceMotionUpdatesForType:(MotionStateUpdateType)type
{
    self.type = type;
    
    PTMotionState *state;
    if (type == MotionStateUpdateVerticalMotion) {
        state = [[StateBegin alloc] initWithContext:self];
    } else if (type == MotionStateUpdatePronation) {
        state = [[StateFaceDown alloc] initWithContext:self];
    } else if (type == MotionStateUpdateSupination) {
        state = [[StateFaceUp alloc] initWithContext:self];
    } else if (type == MotionStateUpdateFlexion) {
        state = [[StateFlexionRaised alloc] initWithContext:self];
    } else if (type == MotionStateUpdateShoulderAbduction) {
        state = [[StateAbductionRaised alloc] initWithContext:self];
    }else if (type == MotionStateUpdateElbowFlexion) {//New Addition
        state = [[ElbowStateFlexionRaised alloc] initWithContext:self];
    }else if (type==MotionStateAbduction2){
        state = [[ShoulderAbductStateLowered alloc] initWithContext:self];

    }else if(type == MotionStateUpdateHoriz){
        state = [[HorizShoulderStateLowered alloc] initWithContext:self];

    }
    
    
    else if (type == MotionStateUpdateUndefined) {
        state = [[StateBegin alloc] initWithContext:self];
    }
    self.state = state;
    
    [self.motionManager startDeviceMotionUpdatesToQueue:self.opQueue withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.state update:motion];
        }];
    }];
}

- (void)startDeviceMotionUpdates {
    [self startDeviceMotionUpdatesForType:MotionStateUpdateUndefined];
}

- (void)stopDeviceMotionUpdates {
    if ([self.motionManager isDeviceMotionActive] == YES) {
        [self.motionManager stopDeviceMotionUpdates];
    }
}

- (void)setState:(PTMotionState *)state
{
    if (_state != state) {
        PTMotionState *oldState = _state;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(motionStateContext:willTransitionFromState:toState:)]) {
                    [self.delegate motionStateContext:self willTransitionFromState:oldState toState:state];
                }
            }
        }];
        
        //NSLog(@"old: %@, new: %@", NSStringFromClass([_state class]), NSStringFromClass([state class]));
        
        _state = state;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(motionStateContext:didChangeState:)]) {
                    [self.delegate motionStateContext:self didChangeState:state];
                }
            }
        }];
    }
}

@end

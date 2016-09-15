//
//  PTViewController.h
//  PTMotion
//
//  Created by David Messing on 10/19/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

@import UIKit;
@import CoreMotion;
@import AudioToolbox;

// PT
#import "PTMotionStateContext.h"
#import "PTMotionState.h"
#import "PTSession.h"

// TU
#import "TUHTTPSessionManager.h"
#import "TUPatient.h"
#import "TUPatientCalibration.h"
#import "PTMotionStateContext+TUPatientCalibration.h"

@interface PTViewController : UIViewController <PTMotionStateContextDelegate, PTSessionDelegate>
{
    SystemSoundID beep;
    SystemSoundID tone;
    SystemSoundID pickup;
}

@property (nonatomic, strong, readonly) PTMotionStateContext *motionStateContext;
@property (nonatomic, strong, readonly) PTSession *session;
@property (nonatomic, strong, readonly) NSMutableArray *sessionObserverTokens;

@property (nonatomic, strong) TUPatient *patient;

- (void)presentUserInstructions:(BOOL)animated; // ABSTRACT

- (void)configureSession; // Must call SUPER
- (void)configureMotionStateContext; // Must call SUPER

@end
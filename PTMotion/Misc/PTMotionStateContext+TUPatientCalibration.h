//
//  PTMotionStateContext+TUPatientCalibration.h
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTMotionStateContext.h"

@class TUPatientCalibration;

@interface PTMotionStateContext (TUPatientCalibration)

- (void)configureWithCalibration:(TUPatientCalibration *)calibration;

@end

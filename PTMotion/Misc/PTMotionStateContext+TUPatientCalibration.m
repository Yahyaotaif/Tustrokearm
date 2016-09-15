//
//  PTMotionStateContext+TUPatientCalibration.m
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTMotionStateContext+TUPatientCalibration.h"

#import "TUPatientCalibration.h"

@implementation PTMotionStateContext (TUPatientCalibration)

- (void)configureWithCalibration:(TUPatientCalibration *)calibration
{
    if (calibration) {
        self.verticalUpperThreshhold = calibration.verticalUpperThreshhold;
        self.verticalLowerThreshhold = calibration.verticalLowerThreshhold;
        
        self.faceDownRollValue = calibration.faceDownRollValue;
        self.faceUpRollValue = calibration.faceUpRollValue;
        self.rollThreshold = calibration.rollThreshold;
        
        self.flexionLoweredValue = calibration.flexionLoweredValue;
        self.flexionRaisedValue = calibration.flexionRaisedValue;
        self.flexionThreshold = calibration.flexionThreshold;
        
        self.abductionLoweredValue = calibration.abductionLoweredValue;
        self.abductionRaisedValue = calibration.abductionRaisedValue;
        self.abductionThreshold = calibration.abductionThreshold;
    }
}

@end

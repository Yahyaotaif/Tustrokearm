//
//  TUPatientCalibration.h
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "JSONModel.h"

@interface TUPatientCalibration : JSONModel

@property (nonatomic, copy) NSString *patientId;
@property (nonatomic) NSUInteger hand;

@property float verticalUpperThreshhold;
@property float verticalLowerThreshhold;

@property float faceDownRollValue;
@property float faceUpRollValue;
@property float rollThreshold;

@property float flexionLoweredValue;
@property float flexionRaisedValue;
@property float flexionThreshold;

@property float abductionLoweredValue;
@property float abductionRaisedValue;
@property float abductionThreshold;

@property float elbowFlexionLoweredValue;
@property float elbowFlexionRaisedValue;
@property float elbowFlexionThreshold;

@property float horizRotateLowValue;
@property float horizRotateRaiseValue;
@property float horizRotateRangeValue;

@property float shouldAbductLowValue;
@property float shouldAbductRaiseValue;
@property float shouldAbductRangeValue;




@end

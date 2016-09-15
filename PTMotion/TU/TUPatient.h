//
//  TUPatient.h
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "JSONModel.h"

@class TUPatientCalibration;

@interface TUPatient : JSONModel

@property (nonatomic, copy) NSString *patientId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, strong) TUPatientCalibration *leftHandCalibration;
@property (nonatomic, strong) TUPatientCalibration *rightHandCalibration;

@end

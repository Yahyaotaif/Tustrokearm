//
//  DailyGoals.h
//  ARMStrokes
//
//  Created by Ted Smith on 5/26/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//


#import "JSONModel.h"



@interface DailyGoals : JSONModel

@property (nonatomic, copy) NSString *patientId;
@property (nonatomic) NSUInteger hand;

@property (nonatomic) NSUInteger fRTLength;
@property (nonatomic) NSUInteger fRTNum;

@property (nonatomic) NSUInteger eFTLength;
@property (nonatomic) NSUInteger eFTNum;

@property (nonatomic) NSUInteger eRFTNum;
@property (nonatomic) NSUInteger eRFTLength;

@property (nonatomic) NSUInteger eRSTLength;
@property (nonatomic) NSUInteger eRSTNum;

@property (nonatomic) NSUInteger sFTLength;
@property (nonatomic) NSUInteger sFTNum;

@property (nonatomic) NSUInteger sRTNum;
@property (nonatomic) NSUInteger sRTLength;

@property (nonatomic) NSUInteger hRTNum;
@property (nonatomic) NSUInteger hRTLength;
@property (nonatomic) NSUInteger sATNum;
@property (nonatomic) NSUInteger sATLength;





@end

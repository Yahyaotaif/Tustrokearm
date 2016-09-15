//
//  TUSession.h
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "JSONModel.h"

@interface TUSession : JSONModel

@property (nonatomic, copy) NSString *patientId;
@property (nonatomic, copy) NSDate *startTime;
@property (nonatomic, copy) NSDate *endTime;

@property (nonatomic) NSUInteger exerciseId;
@property (nonatomic) NSUInteger hand;
@property (nonatomic) NSUInteger actionCount;
@property (nonatomic, copy) NSString *actionValues;

@end

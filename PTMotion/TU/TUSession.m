//
//  TUSession.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "TUSession.h"

@implementation TUSession

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Patient_id": @"patientId",
                                                       @"exercise_id": @"exerciseId",
                                                       @"actioncount" : @"actionCount"
                                                       }];
}


@end

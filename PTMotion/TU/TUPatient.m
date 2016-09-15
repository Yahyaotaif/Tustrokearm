//
//  TUPatient.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "TUPatient.h"

@implementation TUPatient

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ID_patient": @"patientId",
                                                       @"Firstname" : @"firstName",
                                                       @"Lastname" : @"lastName"
                                                       }];
}

@end

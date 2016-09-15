//
//  TUSession+PTSession.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "TUSession+PTSession.h"

#import "PTSession.h"

@implementation TUSession (PTSession)

+ (instancetype)TUSessionWithPTSession:(PTSession *)ptSession
{
    TUSession *tuSession = [[TUSession alloc] init];

    tuSession.startTime = ptSession.startTime;
    tuSession.endTime = ptSession.endTime;

    tuSession.exerciseId = ptSession.exercise;
    tuSession.hand = ptSession.hand;
    tuSession.actionCount = ptSession.actionCount;
    
    // convert action values to a string for storage into db
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:[[ptSession dataPoints] count]];
    for (NSNumber *dataPoint in [ptSession dataPoints]) {
        NSString *string = [NSString stringWithFormat:@"%.5f", [dataPoint doubleValue]];
        [mArray addObject:string];
    }
    tuSession.actionValues = [mArray componentsJoinedByString:@" "];
    
    return tuSession;
}

@end

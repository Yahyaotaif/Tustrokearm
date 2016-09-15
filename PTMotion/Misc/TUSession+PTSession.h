//
//  TUSession+PTSession.h
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "TUSession.h"

@class PTSession;

@interface TUSession (PTSession)

+ (instancetype)TUSessionWithPTSession:(PTSession *)sesssion;

@end

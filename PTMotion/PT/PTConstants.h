//
//  PTConstants.h
//  PTMotion
//
//  Created by David Messing on 12/27/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PTHand) {
    PTHandUndefined,
    PTHandLeft,
    PTHandRight,
};

typedef NS_ENUM(NSUInteger, PTExercise) {
    PTExerciseForearmSupination,
    PTExerciseForearmPronation,
    PTExerciseElbowFlexion,
    PTExerciseElbowRaise,
    PTExerciseElbowRaiseS,
    PTExerciseShoulderFlexion,
    PTExerciseShoulderAbduction,
    PTExerciseHorizShoulderAdduction,
    PTExerciseShoulderRealAbduction
};

@interface PTConstants : NSObject

@end

//
//  MotionState.m
//  MotionTraking
//
//  Created by David Messing on 2/10/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTMotionState.h"
#import "PTMotionStateContext.h"

#import "pthelpers.h"

@interface PTMotionState ()

@end

@implementation PTMotionState

- (id)initWithContext:(PTMotionStateContext *)context
{
    self = [super init];
    if (self) {
        self.context = context;
        
        // initialize default thresholds
        MotionStateUpdateType type = self.context.type;
        if (type == MotionStateUpdateVerticalMotion) {
            // default empty
        } else if (type == MotionStateUpdatePronation) {
            // default empty
        } else if (type == MotionStateUpdateSupination) {
            // default empty
        } else if (type == MotionStateUpdateSupination) {
            // default empty
        } else if (type == MotionStateUpdateUndefined) {
            // default empty
        }
    }
    return self;
}

- (void)update:(CMDeviceMotion *)motion
{
    // abstract
}

#pragma mark -  Utility

/* function to check if value exists between lower and upper bounds */
bool between(double value, double lower, double upper)
{
    return ( value >= lower && value <= upper );
}

@end

// Vertical

@implementation StateBegin

- (void)update:(CMDeviceMotion *)motion
{
    CGFloat accelY = motion.userAcceleration.y;
    
    NSLog(@"Current accelY: %f", accelY);
   
    if (accelY >= self.context.verticalUpperThreshhold) {
        StateUp *state = [[StateUp alloc] initWithContext:self.context];
        [self.context setState:state];
    } else if (accelY <= self.context.verticalLowerThreshhold) {
        StateDown *state = [[StateDown alloc] initWithContext:self.context];
        [self.context setState:state];
    }
    
    
}

@end

@implementation StateUp

- (void)update:(CMDeviceMotion *)motion
{
    CGFloat accelY = motion.userAcceleration.y;
    
    NSLog(@"Current accelY: %f", accelY);
    
   if (accelY < self.context.verticalUpperThreshhold && accelY > self.context.verticalLowerThreshhold) {
        StateBegin *state = [[StateBegin alloc] initWithContext:self.context];
        [self.context setState:state];
    } else if (accelY <= self.context.verticalLowerThreshhold) {
        StateDown *state = [[StateDown alloc] initWithContext:self.context];
        [self.context setState:state];
    }
}

@end
//Tells if it is moving down
@implementation StateDown

- (void)update:(CMDeviceMotion *)motion
{
    CGFloat accelY = motion.userAcceleration.y;
    
    if (accelY > self.context.verticalLowerThreshhold && accelY < self.context.verticalUpperThreshhold) {
        StateBegin *state = [[StateBegin alloc] initWithContext:self.context];
        [self.context setState:state];
    } else if (accelY >= self.context.verticalUpperThreshhold) {
        StateUp *state = [[StateUp alloc] initWithContext:self.context];
        [self.context setState:state];
    }
}

@end

// Rotation
//tells if it is face up
@implementation StateFaceUp

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;

    double roll = currentAttitude.roll;
    double rollDegrees = radiansToDegrees(roll);
    double rollDegreesAbs = fabs(rollDegrees);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current roll: %f", roll);
    
    if ( between(rollDegreesAbs, (self.context.faceDownRollValue - self.context.rollThreshold), (self.context.faceDownRollValue + self.context.rollThreshold)) ) {
        StateFaceDown *state = [[StateFaceDown alloc] initWithContext:self.context];
        [self.context setState:state];
    }
}

@end
//Tells if it is face down
@implementation StateFaceDown

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    double roll = currentAttitude.roll;
    double rollDegrees = radiansToDegrees(roll);
    double rollDegreesAbs = fabs(rollDegrees);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current roll: %f", roll);
    
    if ( between(rollDegreesAbs, (self.context.faceUpRollValue - self.context.rollThreshold), (self.context.faceUpRollValue + self.context.rollThreshold)) ) {
        StateFaceUp *state = [[StateFaceUp alloc] initWithContext:self.context];
        [self.context setState:state];
    }
}

@end

// Flexion

@implementation StateFlexionLowered

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
   double pitch = currentAttitude.pitch;
   double pitchDegrees = radiansToDegrees(pitch);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current pitch: %.0f", pitchDegrees);
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawAbs = fabs(yawDegrees);
    
   /* if ( between(pitchDegrees, (self.context.flexionRaisedValue - self.context.flexionThreshold), (self.context.flexionRaisedValue + self.context.flexionThreshold)) ) {
        StateFlexionRaised *state = [[StateFlexionRaised alloc] initWithContext:self.context];
        [self.context setState:state];
    }*/
    if ( between(yawAbs, (self.context.flexionRaisedValue - self.context.flexionThreshold), (self.context.flexionRaisedValue + self.context.flexionThreshold)) ) {
        StateFlexionRaised *state = [[StateFlexionRaised alloc] initWithContext:self.context];// Reason for opposite
        [self.context setState:state];
    }
     /*NSLog(@"The raised angle is %f",yawDegrees);
     NSLog(@"The raised angle range is %f  and %f",(self.context.flexionRaisedValue - self.context.flexionThreshold),(self.context.flexionRaisedValue + self.context.flexionThreshold));*/
}

@end

@implementation StateFlexionRaised

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    double pitch = currentAttitude.pitch;
   double pitchDegrees = radiansToDegrees(pitch);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current pitch: %.0f", pitchDegrees);
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
   double yawAbs = fabs(yawDegrees);
    
   /* if ( between(pitchDegrees, (self.context.flexionLoweredValue - self.context.flexionThreshold), (self.context.flexionLoweredValue + self.context.flexionThreshold)) ) {
        StateFlexionLowered *state = [[StateFlexionLowered alloc] initWithContext:self.context];
        [self.context setState:state];
    }*/
    
    if ( between(yawAbs, (self.context.flexionLoweredValue - self.context.flexionThreshold), (self.context.flexionLoweredValue + self.context.flexionThreshold)) ) {
        StateFlexionLowered *state = [[StateFlexionLowered alloc] initWithContext:self.context];//Reason for opposite
        [self.context setState:state];
    }
    /*NSLog(@"The lowered angle is %f",yawDegrees);
    NSLog(@"The lowered angle range is %f  and %f",(self.context.flexionLoweredValue - self.context.flexionThreshold),(self.context.flexionLoweredValue + self.context.flexionThreshold));*/
}

@end

// Elbow Flexion

@implementation ElbowStateFlexionLowered

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    //double pitch = currentAttitude.pitch;
    // double pitchDegrees = radiansToDegrees(pitch);
    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", pitchDegrees);
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    /*if ( between(pitchDegrees, (self.context.flexionRaisedValue - self.context.flexionThreshold), (self.context.flexionRaisedValue + self.context.flexionThreshold)) ) {
     StateFlexionRaised *state = [[StateFlexionRaised alloc] initWithContext:self.context];
     [self.context setState:state];
     }*/
    if ( between(yawDegrees, (self.context.elbowFlexionRaisedValue - self.context.elbowFlexionThreshold), (self.context.elbowFlexionRaisedValue + self.context.elbowFlexionThreshold)) ) {
        ElbowStateFlexionRaised *state = [[ElbowStateFlexionRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        /*NSLog(@"The lowered angle is %f",yawDegrees);
        NSLog(@"The lowered angle range is  %f and %f",(self.context.elbowFlexionRaisedValue - self.context.elbowFlexionThreshold),(self.context.elbowFlexionRaisedValue + self.context.elbowFlexionThreshold));*/
    }
    
  

}

@end

@implementation ElbowStateFlexionRaised

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    //double pitch = currentAttitude.pitch;
    //double pitchDegrees = radiansToDegrees(pitch);
    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", pitchDegrees);
    
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    
   /* if ( between(pitchDegrees, (self.context.elbowFlexionLoweredValue - self.context.elbowFlexionThreshold), (self.context.elbowFlexionLoweredValue + self.context.elbowFlexionThreshold)) ) {
        ElbowStateFlexionLowered *state = [[ElbowStateFlexionLowered alloc] initWithContext:self.context];
        [self.context setState:state];
    }*/
    
    if ( between(yawDegrees, (self.context.elbowFlexionLoweredValue - self.context.elbowFlexionThreshold), (self.context.elbowFlexionLoweredValue + self.context.elbowFlexionThreshold)) ) {
        ElbowStateFlexionLowered *state = [[ElbowStateFlexionLowered alloc] initWithContext:self.context];
        [self.context setState:state];
       /* NSLog(@"The raised angle is %f",yawDegrees);
        NSLog(@"The raised angle range is %f  and %f",(self.context.elbowFlexionLoweredValue - self.context.elbowFlexionThreshold),(self.context.elbowFlexionLoweredValue + self.context.elbowFlexionThreshold));*/
    }
   
}

@end

// Abduction

@implementation StateAbductionRaised

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    //For shoulder flexion stuff
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawAbs = fabs(yawDegrees);
    //
    
    double pitch = currentAttitude.pitch;
    double pitchDegrees = radiansToDegrees(pitch);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current pitch: %.0f", pitchDegrees);
    
    /*if ( between(pitchDegrees, (self.context.abductionLoweredValue - self.context.abductionThreshold), (self.context.abductionLoweredValue + self.context.abductionThreshold)) ) {
        StateAbductionLowered *state = [[StateAbductionLowered alloc] initWithContext:self.context];
        [self.context setState:state];
        //I'm doing this to get the yaw values doing the shoulder flexion exercises
        NSLog(@"The raised angle is %f",yawDegrees);
        NSLog(@"The raised angle range is %f  and %f",(self.context.flexionRaisedValue - self.context.flexionThreshold),(self.context.flexionRaisedValue + self.context.flexionThreshold));

    }*/
    
    if ( between(yawAbs, (self.context.abductionLoweredValue - self.context.abductionThreshold), (self.context.abductionLoweredValue + self.context.abductionThreshold)) ) {
        StateAbductionLowered *state = [[StateAbductionLowered alloc] initWithContext:self.context];
        [self.context setState:state];
        //I'm doing this to get the yaw values doing the shoulder flexion exercises
        NSLog(@"The raised angle is %f",yawDegrees);
        NSLog(@"The raised angle range is %f  and %f",(self.context.flexionRaisedValue - self.context.flexionThreshold),(self.context.flexionRaisedValue + self.context.flexionThreshold));
        
    }

}

@end

@implementation StateAbductionLowered

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    //For shoulder flexion stuff
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawAbs = fabs(yawDegrees);
    // end of that
    double pitch = currentAttitude.pitch;
    double pitchDegrees = radiansToDegrees(pitch);
    
//    NSLog(@"Current attitude: %@", currentAttitude);
//    NSLog(@"Current pitch: %.0f", yawDegrees);
    
  /*  if ( between(pitchDegrees, (self.context.abductionRaisedValue - self.context.abductionThreshold), (self.context.abductionRaisedValue + self.context.abductionThreshold)) ) {
        StateAbductionRaised *state = [[StateAbductionRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",yawDegrees);
        NSLog(@"The raised angle range is %f  and %f",(self.context.flexionRaisedValue - self.context.flexionThreshold),(self.context.flexionRaisedValue + self.context.flexionThreshold));

    }*/
    
    if ( between(yawAbs, (self.context.abductionRaisedValue - self.context.abductionThreshold), (self.context.abductionRaisedValue + self.context.abductionThreshold)) ) {
        StateAbductionRaised *state = [[StateAbductionRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",yawDegrees);
        NSLog(@"The raised angle range is %f  and %f",(self.context.flexionRaisedValue - self.context.flexionThreshold),(self.context.flexionRaisedValue + self.context.flexionThreshold));
        
    }

}

@end



@implementation ShoulderAbductStateLowered

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    //For shoulder flexion stuff
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawDegreesAbs = fabs(yawDegrees);
    // end of that
    double pitch = currentAttitude.pitch;
    double pitchDegrees = radiansToDegrees(pitch);
    
    
    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", yawDegrees);
    
    if ( between(yawDegreesAbs, (self.context.shoulderAbductLoweredValue - self.context.shoulderAbductThreshold), (self.context.shoulderAbductLoweredValue + self.context.shoulderAbductThreshold)) ) {
        ShoulderAbductStateRaised *state = [[ShoulderAbductStateRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",yawDegreesAbs);
        NSLog(@"The raised angle range is %f  and %f",(self.context.shoulderAbductLoweredValue - self.context.shoulderAbductThreshold),(self.context.shoulderAbductLoweredValue + self.context.shoulderAbductThreshold));
        
    }

}

@end

@implementation ShoulderAbductStateRaised

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    //For shoulder flexion stuff
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawDegreesAbs = fabs(yawDegrees);
    // end of that
    double pitch = currentAttitude.pitch;
    double pitchDegrees = radiansToDegrees(pitch);
    
    
    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", yawDegrees);
    
    if ( between(yawDegreesAbs, (self.context.shoulderAbductRaisedValue - self.context.shoulderAbductThreshold), (self.context.shoulderAbductRaisedValue + self.context.shoulderAbductThreshold)) ) {
        ShoulderAbductStateLowered *state = [[ShoulderAbductStateLowered alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",yawDegreesAbs);
        NSLog(@"The raised angle range is %f  and %f",(self.context.shoulderAbductRaisedValue - self.context.shoulderAbductThreshold),(self.context.shoulderAbductRaisedValue + self.context.shoulderAbductThreshold));
        
    }
}

@end

@implementation HorizShoulderStateLowered

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    
    double roll = currentAttitude.roll;
    double rollDegrees = radiansToDegrees(roll);
    double rollDegreesAbs = fabs(rollDegrees);
   
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawDegreesAbs = fabs(yawDegrees);
    // end of that

    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", yawDegrees);
    
   /* if ( between(rollDegreesAbs, (self.context.horizShoulderLoweredValue - self.context.horizShoulderThreshold), (self.context.horizShoulderLoweredValue + self.context.horizShoulderThreshold)) ) {
        HorizShoulderStateRaised *state = [[HorizShoulderStateRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",rollDegreesAbs);
        NSLog(@"The raised angle range is %f  and %f",(self.context.horizShoulderLoweredValue - self.context.horizShoulderThreshold),(self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold));
        
    }*/
    
    
    if ( between(yawDegreesAbs, (self.context.horizShoulderLoweredValue - self.context.horizShoulderThreshold), (self.context.horizShoulderLoweredValue + self.context.horizShoulderThreshold)) ) {
        HorizShoulderStateRaised *state = [[HorizShoulderStateRaised alloc] initWithContext:self.context];
        [self.context setState:state];
        /*NSLog(@"The raised angle is %f",rollDegreesAbs);
         NSLog(@"The raised angle range is %f  and %f",(self.context.horizShoulderLoweredValue - self.context.horizShoulderThreshold),(self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold));*/
         NSLog(@"The value in this horiz low is %f and it should be between %f  and %f ",yawDegreesAbs,(self.context.horizShoulderLoweredValue - self.context.horizShoulderThreshold),(self.context.horizShoulderLoweredValue + self.context.horizShoulderThreshold));
    }
   

}

@end

@implementation HorizShoulderStateRaised

- (void)update:(CMDeviceMotion *)motion
{
    CMAttitude *currentAttitude = motion.attitude;
    
    
    double roll = currentAttitude.roll;
    double rollDegrees = radiansToDegrees(roll);
    double rollDegreesAbs = fabs(rollDegrees);
   
    double yaw = currentAttitude.yaw;
    double yawDegrees = radiansToDegrees(yaw);
    double yawDegreesAbs = fabs(yawDegrees);
    // end of that

    
    //    NSLog(@"Current attitude: %@", currentAttitude);
    //    NSLog(@"Current pitch: %.0f", yawDegrees);
    
   /* if ( between(rollDegreesAbs, (self.context.horizShoulderRaisedValue - self.context.horizShoulderThreshold), (self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold)) ) {
        HorizShoulderStateLowered *state = [[HorizShoulderStateLowered alloc] initWithContext:self.context];
        [self.context setState:state];
        NSLog(@"The raised angle is %f",rollDegreesAbs);
        NSLog(@"The raised angle range is %f  and %f",(self.context.horizShoulderRaisedValue- self.context.horizShoulderThreshold),(self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold));
        
    }*/
    
    
    if ( between(yawDegreesAbs, (self.context.horizShoulderRaisedValue - self.context.horizShoulderThreshold), (self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold)) ) {
        HorizShoulderStateLowered *state = [[HorizShoulderStateLowered alloc] initWithContext:self.context];
        [self.context setState:state];
        /*NSLog(@"The raised angle is %f",rollDegreesAbs);
         NSLog(@"The raised angle range is %f  and %f",(self.context.horizShoulderRaisedValue- self.context.horizShoulderThreshold),(self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold));*/
        NSLog(@"The value in this horiz high is %f and it should be between %f  and %f ",yawDegreesAbs,(self.context.horizShoulderRaisedValue - self.context.horizShoulderThreshold),(self.context.horizShoulderRaisedValue + self.context.horizShoulderThreshold));
    }

    
}

@end
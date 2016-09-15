//
//  PTForearmSupinationViewController.m
//  PTMotion
//
//  Created by David Messing on 10/19/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTForearmSupinationViewController.h"

@interface PTForearmSupinationViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

@end

@implementation PTForearmSupinationViewController

#pragma mark - Override

- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    NSString *message = NSLocalizedString(@"Extend your arm and hold the device face up. When the countdown begins, rotate your wrist./n/nSelect which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseForearmSupination;
        self.session.hand = PTHandLeft;
        [self.session startSession];
    }];
    [alertController addAction:actionL];
    UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Right Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseForearmSupination;
        self.session.hand = PTHandRight;
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    
    [self presentViewController:alertController animated:animated completion:nil];
}

#pragma mark - PTSessionDelegate

- (void)sessionStateDidChange:(PTSession*)context
{
    if (self.session.state == PTSessionStateActive) {
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdateSupination];
    } else if (self.session.state == PTSessionStateEnded) {
        [self.motionStateContext stopDeviceMotionUpdates];
        
        [self presentSessionResults];
    }
}

- (void)sessionCountdownTimeDidChange:(PTSession*)context
{
    NSString *timerText = [NSString stringWithFormat:@"Begin in %.0f seconds.", self.session.countdownTimeRemaining];
    [self updateTimerLabel:timerText];
    
    if (self.session.countdownTimeRemaining < 4 && self.session.countdownTimeRemaining > 0) {
        AudioServicesPlaySystemSound(beep);
    }
    
    if (self.session.countdownTimeRemaining == 0) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(tone);
    }
}

- (void)sessionSessionTimeDidChange:(PTSession*)context
{
    if (self.session.sessionTimeRemaining == self.session.sessionTime) {
        return;
    }
    
    NSString *timerText = [NSString stringWithFormat:@"%.0f seconds remaining.", self.session.sessionTimeRemaining];
    [self updateTimerLabel:timerText];
    
    // capture value
    CMMotionManager *manger = self.motionStateContext.motionManager;
    CMDeviceMotion *motion = manger.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    double roll = attitude.roll;
    double rollAbs = fabs(roll);
    [self.session addDataPoint:@(rollAbs)];
}

- (void)sessionActionCountDidChange:(PTSession*)context
{
    NSString *scoreText = [NSString stringWithFormat:@"%lu", (unsigned long)self.session.actionCount];
    [self updateScoreLabel:scoreText];
}

#pragma mark - PTMotionStateContextDelegate

- (void)motionStateContext:(PTMotionStateContext*)context willTransitionFromState:(PTMotionState *)oldState toState:(PTMotionState *)newState
{
    if (self.session.state == PTSessionStateActive) {
        if ([oldState isKindOfClass:[StateFaceUp class]] && [newState isKindOfClass:[StateFaceDown class]]) {
            if (self.monitorForActionCount == NO) {
                self.monitorForActionCount = YES;
            }
        } else if ([oldState isKindOfClass:[StateFaceDown class]] && [newState isKindOfClass:[StateFaceUp class]]) {
            if (self.monitorForActionCount == YES) {
                self.monitorForActionCount = NO;
                [self.session incrementActionCount];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(pickup);
            }
        }  else {
            self.monitorForActionCount = NO;
        }
    }
}

@end

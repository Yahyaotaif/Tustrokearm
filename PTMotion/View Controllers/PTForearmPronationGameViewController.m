//
//  PTForearmPronationGameViewController.m
//  PTMotion
//
//  Created by David Messing on 1/3/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTForearmPronationGameViewController.h"

// views
#import "MonkeyView.h"

// macros
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PTForearmPronationGameViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

// ui
@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;

@end

@implementation PTForearmPronationGameViewController

#pragma mark - Override

- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    NSString *message = NSLocalizedString(@"Extend your arm and hold the device face down. When the countdown begins, rotate your wrist./n/nSelect which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseForearmPronation;
        self.session.hand = PTHandLeft;
        [self.session startSession];
    }];
    [alertController addAction:actionL];
    UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Right Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseForearmPronation;
        self.session.hand = PTHandRight;
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    
    [self presentViewController:alertController animated:animated completion:nil];
}

#pragma mark - View

- (void)configureView
{
    if (self.gameType == PTGameTypeMonkey) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_tree"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey"];
    } else if (self.gameType == PTGameTypeAstronaut) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_orbit"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"astronaut"];
    }
}

- (void)updateTimerLabel:(NSString *)text
{
    self.timerLabel.text = text;
}

- (void)updateScoreLabel:(NSString *)text
{
    self.scoreLabel.text = text;
}

#pragma mark - PTSessionDelegate

- (void)sessionStateDidChange:(PTSession*)context
{
    if (self.session.state == PTSessionStateActive) {
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdatePronation];
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
        if ([oldState isKindOfClass:[StateFaceDown class]] && [newState isKindOfClass:[StateFaceUp class]]) {
            if (self.monitorForActionCount == NO) {
                self.monitorForActionCount = YES;
            }
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                double rads = DEGREES_TO_RADIANS(180);
                self.figureView.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
            } completion:nil];
            
        } else if ([oldState isKindOfClass:[StateFaceUp class]] && [newState isKindOfClass:[StateFaceDown class]]) {
            if (self.monitorForActionCount == YES) {
                self.monitorForActionCount = NO;
                [self.session incrementActionCount];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(pickup);
            }
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                double rads = DEGREES_TO_RADIANS(0);
                self.figureView.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
            } completion:nil];
            
        }  else {
            self.monitorForActionCount = NO;
        }
    }
}

@end

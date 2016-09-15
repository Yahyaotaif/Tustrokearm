//
//  PTShoulderAbductionGameViewController.m
//  PTMotion
//
//  Created by David Messing on 1/3/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTShoulderAbductionGameViewController.h"
#import "pthelpers.h"
// views
#import "MonkeyView.h"

// macros
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PTShoulderAbductionGameViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

// ui
@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;

@end

@implementation PTShoulderAbductionGameViewController

#pragma mark - Override
-(void) viewDidLoad{
    
    NSLog(@"The view loaded in frotate controller");
    [[NSUserDefaults standardUserDefaults] setInteger: 6 forKey:@"exerciseID"];
    [self presentUserInstructions:true];
    [super viewDidLoad];
}
- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    NSString *message = NSLocalizedString(@"1. Hold the device so that the screen faces your ear, and raise your arm.\n 2. Lower your forearm in an arc to waist-level.\n 3. Repeat this motion until the end of the session. \n\nSelect which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    /*UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseShoulderAbduction;
        self.session.hand = PTHandLeft;
        [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionL];*/
   /* UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Ready" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseShoulderAbduction;
        self.session.hand = PTHandRight;
        //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    
    [self presentViewController:alertController animated:animated completion:nil]; */
    
    
    [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
    self.session.exercise = PTExerciseShoulderAbduction;
    self.session.hand = PTHandRight;
    //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
    [self.session startSession];
}

#pragma mark - View

- (void)configureView
{
    /*if (self.gameType == PTGameTypeMonkey) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_no_tree"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey_vine"];
    } else if (self.gameType == PTGameTypeAstronaut) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_orbit"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"astronaut_vine"];
    }*/
    
    if( [[NSUserDefaults standardUserDefaults] integerForKey:@"gameType"] == 0){
        
        self.backgroundView.image = [UIImage imageNamed:@"bg_no_tree"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey_vine"];
   }
    else{
        self.backgroundView.image = [UIImage imageNamed:@"bg_orbit"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"astronaut_vine"];
        
        
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
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdateShoulderAbduction];
    } else if (self.session.state == PTSessionStateEnded) {
        [self.motionStateContext stopDeviceMotionUpdates];
        NSUInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sRcompCount"];
        x++;
        [[NSUserDefaults standardUserDefaults] setInteger: x forKey:@"sRcompCount"];

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
    double pitch = attitude.pitch;
    double yaw = attitude.yaw;
    double yawAbs = fabs(yaw);
    [self.session addDataPoint:@(yawAbs)];
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
        if ([oldState isKindOfClass:[StateAbductionRaised class]] && [newState isKindOfClass:[StateAbductionLowered class]]) {
            if (self.monitorForActionCount == NO) {
                self.monitorForActionCount = YES;
            }
        } else if ([oldState isKindOfClass:[StateAbductionLowered class]] && [newState isKindOfClass:[StateAbductionRaised class]]) {
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

- (void)motionStateContext:(PTMotionStateContext*)context didChangeState:(PTMotionState *)state
{
    if ([state isKindOfClass:[StateAbductionLowered class]]) {
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            double rads = DEGREES_TO_RADIANS(-25);
            self.figureView.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
        } completion:nil];
        
        // capture value
        CMMotionManager *manger = self.motionStateContext.motionManager;
        CMDeviceMotion *motion = manger.deviceMotion;
        CMAttitude *attitude = motion.attitude;
        double pitch = attitude.pitch;
        double pitchDegrees = pitch * 180 / 3.14;
        double pitchAbs = fabs(pitchDegrees);
        NSLog(@"Shoulder flex low %f",pitchAbs);
    } else if ([state isKindOfClass:[StateAbductionRaised class]]) {
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            double rads = DEGREES_TO_RADIANS(25);
            self.figureView.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
        } completion:nil];
        
        // capture value
        CMMotionManager *manger = self.motionStateContext.motionManager;
        CMDeviceMotion *motion = manger.deviceMotion;
        CMAttitude *attitude = motion.attitude;
        double pitch = attitude.pitch;
        double pitchDegrees = pitch * 180 / 3.14;
        double pitchAbs = fabs(pitchDegrees);
        NSLog(@"Shoulder flex raised %f",pitchAbs);
    }
}
@end

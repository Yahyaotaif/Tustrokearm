//
//  PTElbowFlexionGameViewController.m
//  PTMotion
//
//  Created by David Messing on 1/3/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTElbowFlexionGameViewController.h"
#import "pthelpers.h"
// views
#import "MonkeyView.h"

@interface PTElbowFlexionGameViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

// ui
@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *centerConstraint;

@end

@implementation PTElbowFlexionGameViewController

#pragma mark - Override
-(void) viewDidLoad{
    
    NSLog(@"The view loaded in elbflex controller");
    [[NSUserDefaults standardUserDefaults] setInteger: 2 forKey:@"exerciseID"];
    [self presentUserInstructions:true];
    [super viewDidLoad];
}
- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    //NSString *message = NSLocalizedString(@"Hold the phone flat (so that you can see the screen and raise your elbow to your ear. When the countdown begins, extend your elbow until your arm is straight, then raise it again./n/nSelect which hand you are using for this exercise to begin.", @"message");
    NSString *message = NSLocalizedString(@"1. Hold the phone so that the screen is facing your body. \n 2. Raise your hand to your ear.\n 3. When the countdown begins, extend your elbow until your arm is straight along the side of your body.\n 4. Then, repeat the motions until end of session.\n\nSelect which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   /* UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseElbowFlexion;
        self.session.hand = PTHandLeft;
        [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionL];*/
    /*UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Ready" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseElbowFlexion;
        self.session.hand = PTHandRight;
        //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    [self presentViewController:alertController animated:animated completion:nil];*/
    
    
    [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
    self.session.exercise = PTExerciseElbowFlexion;
    self.session.hand = PTHandRight;
    //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
    [self.session startSession];

}

#pragma mark - View

- (void)configureView
{
    /*if (self.gameType == PTGameTypeMonkey) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_tree"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey"];
    } else if (self.gameType == PTGameTypeAstronaut) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_orbit"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"astronaut"];
    }*/
    
    if( [[NSUserDefaults standardUserDefaults] integerForKey:@"gameType"] == 0){
        
        self.backgroundView.image = [UIImage imageNamed:@"bg_tree"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey"];
    }
    else{
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
      NSLog(@"The score label is %@ but should be %@",text,self.scoreLabel.text);
}

#pragma mark - PTSessionDelegate

- (void)sessionStateDidChange:(PTSession*)context
{
    if (self.session.state == PTSessionStateActive) {
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdateElbowFlexion];
    } else if (self.session.state == PTSessionStateEnded) {
        [self.motionStateContext stopDeviceMotionUpdates];
        NSUInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"eFcompCount"];
        x++;
        [[NSUserDefaults standardUserDefaults] setInteger: x forKey:@"eFcompCount"];

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
    /*CMMotionManager *manger = self.motionStateContext.motionManager;
    CMDeviceMotion *motion = manger.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    double pitch = attitude.pitch;
     */
    // capture value
    CMMotionManager *manger = self.motionStateContext.motionManager;
    CMDeviceMotion *motion = manger.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    double yaw = attitude.yaw;
   double yawDegrees = radiansToDegrees(yaw);
    [self.session addDataPoint:@(yawDegrees)];
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
        if ([oldState isKindOfClass:[ElbowStateFlexionRaised class]] && [newState isKindOfClass:[ElbowStateFlexionLowered class]]) {
            if (self.monitorForActionCount == NO) {
                self.monitorForActionCount = YES;
                // NSLog(@"The elbow flexion lowered");
            }
            
            // capture value
            CMMotionManager *manger = self.motionStateContext.motionManager;
            CMDeviceMotion *motion = manger.deviceMotion;
            CMAttitude *attitude = motion.attitude;
            double yaw = attitude.yaw;
            double yawDegrees = yaw * 180 / 3.14;
            double yawAbs = fabs(yawDegrees);
            NSLog(@"Elbow flex raised %f",yawAbs);
            
        } else if ([oldState isKindOfClass:[ElbowStateFlexionLowered class]] && [newState isKindOfClass:[ElbowStateFlexionRaised class]]) {
            if (self.monitorForActionCount == YES) {
                self.monitorForActionCount = NO;
                [self.session incrementActionCount];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(pickup);
                //NSLog(@"The elbow flexion raised");
                //NSLog(@"the action count is %d", self.actionCount);
            }
            // capture value
            CMMotionManager *manger = self.motionStateContext.motionManager;
            CMDeviceMotion *motion = manger.deviceMotion;
            CMAttitude *attitude = motion.attitude;
            double yaw = attitude.yaw;
            double yawDegrees = yaw * 180 / 3.14;
            double yawAbs = fabs(yawDegrees);
            NSLog(@"Elbow flex low %f",yawAbs);
        }  else {
            self.monitorForActionCount = NO;
        }
    }
}

- (void)motionStateContext:(PTMotionStateContext*)context didChangeState:(PTMotionState *)state
{
    CGFloat translation = 100.0;
    
    if ([state isKindOfClass:[ElbowStateFlexionLowered class]]) {
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.centerConstraint.constant = translation;
            [self.view layoutIfNeeded];
           // NSLog(@"the elbow lowered in gui");
        } completion:nil];
        
       
       
        
    } else if ([state isKindOfClass:[ElbowStateFlexionRaised class]]) {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.centerConstraint.constant = -translation;
            [self.view layoutIfNeeded];
            // NSLog(@"the elbow raised in gui");
        } completion:nil];
        
        
    }
}

@end

//
//  PTElbowRaiseSGameViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 4/15/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//



#import "PTElbowRaiseSGameViewController.h"

// views
#import "MonkeyView.h"

@interface PTElbowRaiseSGameViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

// ui
@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *centerConstraint;

@end

@implementation PTElbowRaiseSGameViewController

#pragma mark - Override
-(void) viewDidLoad{
    
    NSLog(@"The view loaded in frotate controller");
    [[NSUserDefaults standardUserDefaults] setInteger: 4 forKey:@"exerciseID"];
    [self presentUserInstructions:true];
    [super viewDidLoad];
}
- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    NSString *message = NSLocalizedString(@"1. Hold the phone so that the screen is facing your body.\n 2. When the countdown begins, raise your arm to an extended position over your head.\n 3. Lower the phone to its original positin.\n 4. Repeat the motions until the end of session.\n\n Select which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    /*UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseElbowRaise;
        self.session.hand = PTHandLeft;
        [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionL];*/
    /*UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Ready" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseElbowRaise;
        self.session.hand = PTHandRight;
       // [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    
    [self presentViewController:alertController animated:animated completion:nil];*/
    
    
    [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
    self.session.exercise = PTExerciseElbowRaiseS;
    self.session.hand = PTHandRight;
    // [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
    [self.session startSession];

}

#pragma mark - View

- (void)configureView
{
    /*if (self.gameType == PTGameTypeMonkey) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_tree_short"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey"];
    } else if (self.gameType == PTGameTypeAstronaut) {
        self.backgroundView.image = [UIImage imageNamed:@"bg_orbit"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"astronaut"];
    }*/
    
    if( [[NSUserDefaults standardUserDefaults] integerForKey:@"gameType"] == 0){
        
        self.backgroundView.image = [UIImage imageNamed:@"bg_tree_short"];
        self.figureView.figureImageView.image = [UIImage imageNamed:@"monkey"];    }
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
}

#pragma mark - PTSessionDelegate

- (void)sessionStateDidChange:(PTSession*)context
{
    if (self.session.state == PTSessionStateActive) {
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdateVerticalMotion];
    } else if (self.session.state == PTSessionStateEnded) {
        [self.motionStateContext stopDeviceMotionUpdates];
        NSUInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"eRScompCount"];
        x++;
        [[NSUserDefaults standardUserDefaults] setInteger: x forKey:@"eRScompCount"];

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
    CMAcceleration acceleration = motion.userAcceleration;
    double y = acceleration.y;
    [self.session addDataPoint:@(y)];
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
        if ([oldState isKindOfClass:[StateUp class]] && [newState isKindOfClass:[StateBegin class]]) {
            if (self.monitorForActionCount == NO) {
                self.monitorForActionCount = YES;
                
            }
        } else if ([oldState isKindOfClass:[StateBegin class]] && [newState isKindOfClass:[StateDown class]]) {
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
    CGPoint figureCenter = self.figureView.center;
    CGPoint viewCenter = self.view.center;
    CGFloat translation = 100.0;
    // NSLog(@"The state is %d",state);
    if ([state isKindOfClass:[StateBegin class]]) {
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.centerConstraint.constant = 0;
            [self.view layoutIfNeeded];
        } completion:nil];
        
    } else if ([state isKindOfClass:[StateUp class]]) {
        figureCenter.y = viewCenter.y - translation;
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.centerConstraint.constant = translation;
            [self.view layoutIfNeeded];
        } completion:nil];
        
        
        // capture value
        CMMotionManager *manger = self.motionStateContext.motionManager;
        CMDeviceMotion *motion = manger.deviceMotion;
        CMAcceleration acceleration = motion.userAcceleration;
        double y = acceleration.y;
        NSLog(@"Moved up %f",y);
        
    } else if ([state isKindOfClass:[StateDown class]]) {
        figureCenter.y = viewCenter.y + translation;
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.centerConstraint.constant = -translation;
            [self.view layoutIfNeeded];
        } completion:nil];
        
        
        // capture value
        CMMotionManager *manger = self.motionStateContext.motionManager;
        CMDeviceMotion *motion = manger.deviceMotion;
        CMAcceleration acceleration = motion.userAcceleration;
        double y = acceleration.y;
        NSLog(@"Moved down %f",y);
    }
}

@end

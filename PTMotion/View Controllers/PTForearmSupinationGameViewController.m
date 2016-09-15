//
//  PTForearmSupinationGameViewController.m
//  PTMotion
//
//  Created by David Messing on 1/3/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "PTForearmSupinationGameViewController.h"
#import "pthelpers.h"
// views
#import "MonkeyView.h"

// macros
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PTForearmSupinationGameViewController ()

// private
@property (nonatomic) BOOL monitorForActionCount;

// ui
@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;

@end

@implementation PTForearmSupinationGameViewController

#pragma mark - Override
-(void) viewDidLoad{
    
    NSLog(@"The view loaded in frotate controller");
    [[NSUserDefaults standardUserDefaults] setInteger: 1 forKey:@"exerciseID"];
    [self presentUserInstructions:true];
    [super viewDidLoad];
}
- (void)presentUserInstructions:(BOOL)animated
{
    NSString *title = NSLocalizedString(@"Instructions", @"title");
    NSString *message = NSLocalizedString(@"1. Extend your arm, and hold the device with the screen face up.\n 2. When the countdown begins, rotate your wrist.\n\nSelect which hand you are using for this exercise to begin.", @"message");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   /* UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 40, 40)];
    
    NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"apple_raw.png"]];
    UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
    [imageView setImage:bkgImg];*/
    //[bkgImg release];
    //[path release];
    
    //[successAlert addSubview:imageView];
    //[imageView release];
    
   // [successAlert show];
    //[successAlert release];
    /*UIAlertAction *actionL = [UIAlertAction actionWithTitle:@"Left Hand" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.leftHandCalibration];
        self.session.exercise = PTExerciseForearmSupination;
        self.session.hand = PTHandLeft;
        [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionL];*/
   /* UIAlertAction *actionR = [UIAlertAction actionWithTitle:@"Ready" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
        self.session.exercise = PTExerciseForearmSupination;
        self.session.hand = PTHandRight;
        //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        [self.session startSession];
    }];
    [alertController addAction:actionR];
    
    [self presentViewController:alertController animated:animated completion:nil];*/
    
    [self.motionStateContext configureWithCalibration:self.patient.rightHandCalibration];
    self.session.exercise = PTExerciseForearmSupination;
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
}

#pragma mark - PTSessionDelegate

- (void)sessionStateDidChange:(PTSession*)context
{
    if (self.session.state == PTSessionStateActive) {
        [self.motionStateContext startDeviceMotionUpdatesForType:MotionStateUpdateSupination];
    } else if (self.session.state == PTSessionStateEnded) {
        [self.motionStateContext stopDeviceMotionUpdates];
        NSUInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"fRcompCount"];
        x++;
        [[NSUserDefaults standardUserDefaults] setInteger: x forKey:@"fRcompCount"];
        

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
    //double rollAbs = fabs(roll);
    double rollDegrees = radiansToDegrees(roll);
    double rollDegreesAbs = fabs(rollDegrees);
    
    [self.session addDataPoint:@(rollDegreesAbs)];
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
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                double rads = DEGREES_TO_RADIANS(180);
                self.figureView.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
            } completion:nil];
            // capture value
            CMMotionManager *manger = self.motionStateContext.motionManager;
            CMDeviceMotion *motion = manger.deviceMotion;
            CMAttitude *attitude = motion.attitude;
            double roll = attitude.roll;
            double rollDegrees = roll * 180 /3.14;
            double rollAbs = fabs(rollDegrees);
            NSLog(@"Face Down %f",rollAbs);
            
        } else if ([oldState isKindOfClass:[StateFaceDown class]] && [newState isKindOfClass:[StateFaceUp class]]) {
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
            
            // capture value
            CMMotionManager *manger = self.motionStateContext.motionManager;
            CMDeviceMotion *motion = manger.deviceMotion;
            CMAttitude *attitude = motion.attitude;
            double roll = attitude.roll;
            double rollDegrees = roll * 180 /3.14;
            double rollAbs = fabs(rollDegrees);
            NSLog(@"Face Up %f",rollAbs);
            
        }  else {
            self.monitorForActionCount = NO;
        }
    }
}

@end

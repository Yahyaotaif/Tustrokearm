//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewController.h"

@interface AnimateViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewController
/*
- (IBAction)pressed:(id)sender {
    
    //[self performSegueWithIdentifier:@"horiz" sender:self];
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"itpressed");
}
*/
- (void)viewDidLoad {
    
    if([[NSUserDefaults standardUserDefaults] floatForKey:@"animateBut"]==0){
        
        [self performSegueWithIdentifier:@"horiz" sender:self];
        
        NSLog(@"Animate but is off %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"animateBut"]);
    }
    
    else{
        NSLog(@"Animate but is on, %f",[[NSUserDefaults standardUserDefaults] floatForKey:@"animateBut"]);
        
        
        
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addImageViewWithAnimation];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addImageViewWithAnimation{
    
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==1){//forearm rotation animation
        
           self.textDisplay = [[UITextView alloc]initWithFrame:CGRectMake(0,310,300,400)];
[self.textDisplay sizeToFit];
        self.textDisplay.text = @"1. Extend your arm, and hold the device with the screen face up.\n 2. When the countdown begins, rotate your wrist.\n\nSelect which hand you are using for this exercise to begin.";
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"forearmRot1.jpg"],
                                        [UIImage imageNamed:@"forearmRot2.jpg"],[UIImage imageNamed:@"forearmRot3.jpg"],
                                        [UIImage imageNamed:@"forearmRot4.jpg"],[UIImage imageNamed:@"forearmRot5.jpg"],
                                        [UIImage imageNamed:@"forearmRot6.jpg"],[UIImage imageNamed:@"forearmRot7.jpg"],
                                        [UIImage imageNamed:@"forearmRot8.jpg"],[UIImage imageNamed:@"forearmRot9.jpg"],
                                        [UIImage imageNamed:@"forearmRot10.jpg"], [UIImage imageNamed:@"forearmRot11.jpg"],[UIImage imageNamed:@"forearmRot12.jpg"],[UIImage imageNamed:@"forearmRot13.jpg"],[UIImage imageNamed:@"forearmRot14.jpg"], nil];
        self.imgview.animationDuration = 42.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
        
    }
    
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==2){//elbow flexion animation
        
        self.textDisplay.text = @"1. Hold the phone so that the screen is facing your body. \n 2. Raise your hand to your ear.\n 3. When the countdown begins, extend your elbow until your arm is straight along the side of your body.\n 4. Then, repeat the motions until end of session.\n\nSelect which hand you are using for this exercise to begin.";
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowFlex1.jpg"],
                                        [UIImage imageNamed:@"elbowFlex2.jpg"],[UIImage imageNamed:@"elbowFlex3.jpg"],
                                        [UIImage imageNamed:@"elbowFlex4.jpg"],[UIImage imageNamed:@"elbowFlex5.jpg"],
                                        [UIImage imageNamed:@"elbowFlex6.jpg"],[UIImage imageNamed:@"elbowFlex7.jpg"],
                                        [UIImage imageNamed:@"elbowFlex8.jpg"],[UIImage imageNamed:@"elbowFlex9.jpg"],
                                        [UIImage imageNamed:@"elbowFlex10.jpg"], [UIImage imageNamed:@"elbowFlex11.jpg"], nil];
        self.imgview.animationDuration = 33.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];
        
        
        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==3){//Elbow Raise to  Front
     
        self.textDisplay.text = @"1. Hold the phone so that the screen is facing your body.\n 2. When the countdown begins, raise your arm to an extended position over your head.\n 3. Lower the phone to its original positin.\n 4. Repeat the motions until the end of session.\n\n Select which hand you are using for this exercise to begin.";
        
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowRaiseFront1.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront2.jpg"],[UIImage imageNamed:@"elbowRaiseFront3.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront4.jpg"],[UIImage imageNamed:@"elbowRaiseFront5.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront6.jpg"],[UIImage imageNamed:@"elbowRaiseFront7.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront8.jpg"],[UIImage imageNamed:@"elbowRaiseFront9.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront10.jpg"], [UIImage imageNamed:@"elbowRaiseFront11.jpg"],[UIImage imageNamed:@"elbowRaiseFront12.jpg"], nil];
        self.imgview.animationDuration = 36.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==4){//Elbow Raise to Side
        
        self.textDisplay.text = @"1. Hold the phone so that the screen is facing your body.\n 2. When the countdown begins, raise your arm to an extended position over your head.\n 3. Lower the phone to its original positin.\n 4. Repeat the motions until the end of session.\n\n Select which hand you are using for this exercise to begin.";
        
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowRaise1.jpg"],
                                        [UIImage imageNamed:@"elbowRaise2.jpg"],[UIImage imageNamed:@"elbowRaise3.jpg"],
                                        [UIImage imageNamed:@"elbowRaise4.jpg"],[UIImage imageNamed:@"elbowRaise5.jpg"],
                                        [UIImage imageNamed:@"elbowRaise6.jpg"],[UIImage imageNamed:@"elbowRaise7.jpg"],
                                        [UIImage imageNamed:@"elbowRaise8.jpg"],[UIImage imageNamed:@"elbowRaise9.jpg"],
                                        [UIImage imageNamed:@"elbowRaise10.jpg"], [UIImage imageNamed:@"elbowRaise11.jpg"],[UIImage imageNamed:@"elbowRaise12.jpg"],[UIImage imageNamed:@"elbowRaise13.jpg"], nil];
        self.imgview.animationDuration = 39.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==5){//Shoulder Flexion
        
        self.textDisplay.text = @"1. Hold the device so that the screen faces your body.\n 2.Raise your arm in an arc.\n 3. Lower your arm in an arc to waist-level.\n 4.Repeat this motion until the end of the session.\n\nSelect which hand you are using for this exercise to begin.";
        
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderFlex1.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex2.jpg"],[UIImage imageNamed:@"shoulderFlex3.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex4.jpg"],[UIImage imageNamed:@"shoulderFlex5.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex6.jpg"],[UIImage imageNamed:@"shoulderFlex7.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex8.jpg"],[UIImage imageNamed:@"shoulderFlex9.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex10.jpg"], [UIImage imageNamed:@"shoulderFlex11.jpg"],[UIImage imageNamed:@"shoulderFlex12.jpg"],[UIImage imageNamed:@"shoulderFlex13.jpg"], nil];
        self.imgview.animationDuration = 39.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==6){//Shoulder Rotation
       
        self.textDisplay.text = @"1. Hold the device so that the screen faces your ear, and raise your arm.\n 2. Lower your forearm in an arc to waist-level.\n 3. Repeat this motion until the end of the session. \n\nSelect which hand you are using for this exercise to begin.";
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderRotation1.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation2.jpg"],[UIImage imageNamed:@"shoulderRotation3.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation4.jpg"],[UIImage imageNamed:@"shoulderRotation5.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation6.jpg"],[UIImage imageNamed:@"shoulderRotation7.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation8.jpg"],[UIImage imageNamed:@"shoulderRotation9.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation10.jpg"], [UIImage imageNamed:@"shoulderRotation11.jpg"],[UIImage imageNamed:@"shoulderRotation12.jpg"],[UIImage imageNamed:@"shoulderRotation13.jpg"], [UIImage imageNamed:@"shoulderRotation14.jpg"], nil];
        self.imgview.animationDuration = 42.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==7){//Horizontal Shoulder Rotation
       
        //Should be changed once videos are recorded
         self.textDisplay.text = @"1. Extend your arm, and hold the device with the screen face up.\n2. When the countdown begins, rotate your wrist.";
       // self.textDisplay = [[UITextView alloc]initWithFrame:CGRectMake(0,10,200,400)];
        //[self.textDisplay sizeToFit];
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(0, 10, 320, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderRotation1.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation2.jpg"],[UIImage imageNamed:@"shoulderRotation3.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation4.jpg"],[UIImage imageNamed:@"shoulderRotation5.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation6.jpg"],[UIImage imageNamed:@"shoulderRotation7.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation8.jpg"],[UIImage imageNamed:@"shoulderRotation9.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation10.jpg"], [UIImage imageNamed:@"shoulderRotation11.jpg"],[UIImage imageNamed:@"shoulderRotation12.jpg"],[UIImage imageNamed:@"shoulderRotation13.jpg"], [UIImage imageNamed:@"shoulderRotation14.jpg"], nil];
        self.imgview.animationDuration = 42.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==8){//Shoulder Adduction
        
        //Should be changed once videos are recorded
        self.textDisplay.text = @"1. Extend your arm, and hold the device with the screen face up.\n 2. When the countdown begins, rotate your wrist.\n\nSelect which hand you are using for this exercise to begin.";
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderRotation1.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation2.jpg"],[UIImage imageNamed:@"shoulderRotation3.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation4.jpg"],[UIImage imageNamed:@"shoulderRotation5.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation6.jpg"],[UIImage imageNamed:@"shoulderRotation7.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation8.jpg"],[UIImage imageNamed:@"shoulderRotation9.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation10.jpg"], [UIImage imageNamed:@"shoulderRotation11.jpg"],[UIImage imageNamed:@"shoulderRotation12.jpg"],[UIImage imageNamed:@"shoulderRotation13.jpg"], [UIImage imageNamed:@"shoulderRotation14.jpg"], nil];
        self.imgview.animationDuration = 42.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];
        
        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

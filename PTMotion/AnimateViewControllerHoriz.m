//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerHoriz.h"

@interface AnimateViewControllerHoriz ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerHoriz
/*
- (IBAction)pressed:(id)sender {
    
    //[self performSegueWithIdentifier:@"horiz" sender:self];
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"itpressed");
}
*/

- (void)viewDidLoad {
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"animateBut"]==0){
        
        //[self performSegueWithIdentifier:@"horiz" sender:self];
        [self performSegueWithIdentifier:@"horiz2" sender:self];
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
    
    
    //Horizontal Shoulder Rotation
       
        //Should be changed once videos are recorded
         //self.textDisplay.text = @"1. Extend your arm, and hold the device with the screen face up.\n2. When the countdown begins, rotate your wrist.\n3. Repeat.";
    
    
    self.textDisplay.text = @"1. Hold the phone upwards in the hand. \n\n2. The phone should be facing to the front in the direction your body faces when looking forward. \n\n3. Rotate your shoulder horizontally to front.";
    
       // self.textDisplay = [[UITextView alloc]initWithFrame:CGRectMake(0,10,200,400)];
        //[self.textDisplay sizeToFit];
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(0, 10, 320, 400)];
        // set an animation
       /* self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"HorizAdduc1.jpg"],[UIImage imageNamed:@"HorizAdduc1.jpg"],
                                        [UIImage imageNamed:@"HorizAdduc2.jpg"],[UIImage imageNamed:@"HorizAdduc2.jpg"],
                                        [UIImage imageNamed:@"HorizAdduc3.jpg"],[UIImage imageNamed:@"HorizAdduc3.jpg"],
                                        [UIImage imageNamed:@"HorizAdduc4.jpg"],[UIImage imageNamed:@"HorizAdduc4.jpg"], nil];*/
    
    self.imgview.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"horizontalAbduction1.jpg"],[UIImage imageNamed:@"horizontalAbduction2.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction3.jpg"],[UIImage imageNamed:@"horizontalAbduction4.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction5.jpg"],[UIImage imageNamed:@"horizontalAbduction6.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction7.jpg"],[UIImage imageNamed:@"horizontalAbduction8.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction9.jpg"],[UIImage imageNamed:@"horizontalAbduction10.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction11.jpg"],[UIImage imageNamed:@"horizontalAbduction12.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction13.jpg"],[UIImage imageNamed:@"horizontalAbduction14.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction15.jpg"],[UIImage imageNamed:@"horizontalAbduction16.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction17.jpg"],[UIImage imageNamed:@"horizontalAbduction18.jpg"],
                                    [UIImage imageNamed:@"horizontalAbduction19.jpg"],[UIImage imageNamed:@"horizontalAbduction20.jpg"],nil];
        self.imgview.animationDuration = 60.0/30;
        self.imgview.contentMode = UIViewContentModeCenter;
        [self.imgview startAnimating];
        [self.view addSubview:self.imgview];

        
        
    
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

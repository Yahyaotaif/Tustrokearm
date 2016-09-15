//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerSRot.h"

@interface AnimateViewControllerSRot ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerSRot
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
        
        [self performSegueWithIdentifier:@"srot" sender:self];
        
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
    
    //Shoulder Rotation
       
        self.textDisplay.text = @"1. Hold the device to your side with the screen facing your ear and your arm bent at 90 degrees.\n2. At “Start”, keep your elbow in place, bent and rotate your arm downward.\n3. Repeat.";
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderRotation1.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation2.jpg"],[UIImage imageNamed:@"shoulderRotation3.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation4.jpg"],[UIImage imageNamed:@"shoulderRotation5.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation6.jpg"],[UIImage imageNamed:@"shoulderRotation7.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation8.jpg"],[UIImage imageNamed:@"shoulderRotation9.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation10.jpg"], [UIImage imageNamed:@"shoulderRotation11.jpg"],[UIImage imageNamed:@"shoulderRotation12.jpg"],[UIImage imageNamed:@"shoulderRotation13.jpg"], [UIImage imageNamed:@"shoulderRotation14.jpg"], [UIImage imageNamed:@"shoulderRotation15.jpg"],[UIImage imageNamed:@"shoulderRotation16.jpg"],
                                        [UIImage imageNamed:@"shoulderRotation17.jpg"], [UIImage imageNamed:@"shoulderRotation18.jpg"],[UIImage imageNamed:@"shoulderRotation19.jpg"],[UIImage imageNamed:@"shoulderRotation20.jpg"],nil];
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

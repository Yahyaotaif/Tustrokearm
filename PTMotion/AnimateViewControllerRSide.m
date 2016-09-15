//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerRSide.h"

@interface AnimateViewControllerRSide ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerRSide
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
        
        [self performSegueWithIdentifier:@"rside" sender:self];
        
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
    
    
    //Elbow Raise to Side
        
        self.textDisplay.text = @"1. Hold the device to your side with the screen facing your ear.\n2. Your arm should be bent at a 90 degree angle.\n3. At “Start”, raise device straight up, extending your arm.\n4. Repeat.";
    

    
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowRaiseSide1.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide2.jpg"],[UIImage imageNamed:@"elbowRaiseSide3.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide4.jpg"],[UIImage imageNamed:@"elbowRaiseSide5.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide6.jpg"],[UIImage imageNamed:@"elbowRaiseSide7.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide8.jpg"],[UIImage imageNamed:@"elbowRaiseSide9.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide10.jpg"], [UIImage imageNamed:@"elbowRaiseSide11.jpg"],[UIImage imageNamed:@"elbowRaiseSide12.jpg"],[UIImage imageNamed:@"elbowRaiseSide13.jpg"],[UIImage imageNamed:@"elbowRaiseSide14.jpg"],[UIImage imageNamed:@"elbowRaiseSide15.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseSide16.jpg"], [UIImage imageNamed:@"elbowRaiseSide17.jpg"], nil];
        self.imgview.animationDuration = 51.0/30;
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

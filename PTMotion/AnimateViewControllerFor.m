//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerFor.h"

@interface AnimateViewControllerFor ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerFor
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
        
        [self performSegueWithIdentifier:@"for" sender:self];
        
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
    
    
   //forearm rotation animation
        
          // self.textDisplay = [[UITextView alloc]initWithFrame:CGRectMake(0,310,300,400)];
//[self.textDisplay sizeToFit];
        self.textDisplay.text = @"1. Hold device face up and Extend arm forward.\n2. At “Start”, rotate your wrist to face the device screen down.\n3. Repeat.";

        
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

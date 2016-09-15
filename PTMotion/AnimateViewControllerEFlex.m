//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerEFlex.h"

@interface AnimateViewControllerEFlex ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerEFlex
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
        
        [self performSegueWithIdentifier:@"eflex" sender:self];
        
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
    
    
    //elbow flexion animation
        
    self.textDisplay.text = @"1. Hold device with screen facing your body\n2. Extend arm to the side of your hip.\n3. At “Start”, bend arm at elbow and raise your device upward.\n4. Repeat";
  
        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowF1.jpg"],
                                        [UIImage imageNamed:@"elbowF2.jpg"],[UIImage imageNamed:@"elbowF3.jpg"],
                                        [UIImage imageNamed:@"elbowF4.jpg"],[UIImage imageNamed:@"elbowF5.jpg"],
                                        [UIImage imageNamed:@"elbowF6.jpg"],[UIImage imageNamed:@"elbowF7.jpg"],
                                        [UIImage imageNamed:@"elbowF8.jpg"],[UIImage imageNamed:@"eelbowF9.jpg"],
                                        [UIImage imageNamed:@"elbowF10.jpg"], [UIImage imageNamed:@"elbowF11.jpg"],[UIImage imageNamed:@"elbowF12.jpg"],
                                        [UIImage imageNamed:@"elbowF13.jpg"],[UIImage imageNamed:@"elbowF14.jpg"],
                                        [UIImage imageNamed:@"elbowF15.jpg"],[UIImage imageNamed:@"elbowF16.jpg"],
                                        [UIImage imageNamed:@"elbowF17.jpg"],[UIImage imageNamed:@"elbowF18.jpg"],
                                        [UIImage imageNamed:@"elbowF19.jpg"],[UIImage imageNamed:@"elbowF20.jpg"],nil];
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

//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerSFlex.h"

@interface AnimateViewControllerSFlex ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerSFlex
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
        
        [self performSegueWithIdentifier:@"sflex" sender:self];
        
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
    
    
    //Shoulder Flexion
        
        self.textDisplay.text = @"1. Hold device to your side with screen facing your body at hip.\n2. At “Start”, keep your arm straight and raise device straight up above the side of your head.\n3. Repeat.";
    
    

        
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        /*self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"shoulderFlex1.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex2.jpg"],[UIImage imageNamed:@"shoulderFlex3.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex4.jpg"],[UIImage imageNamed:@"shoulderFlex5.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex6.jpg"],[UIImage imageNamed:@"shoulderFlex7.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex8.jpg"],[UIImage imageNamed:@"shoulderFlex9.jpg"],
                                        [UIImage imageNamed:@"shoulderFlex10.jpg"], [UIImage imageNamed:@"shoulderFlex11.jpg"],[UIImage imageNamed:@"shoulderFlex12.jpg"],[UIImage imageNamed:@"shoulderFlex13.jpg"], nil];*/
    
    /*self.imgview.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"ShouldFlex1.jpg"],[UIImage imageNamed:@"ShouldFlex1.jpg"],
                                    [UIImage imageNamed:@"ShouldFlex2.jpg"],[UIImage imageNamed:@"ShouldFlex2.jpg"],
                                    [UIImage imageNamed:@"ShouldFlex3.jpg"],[UIImage imageNamed:@"ShouldFlex3.jpg"],
                                    [UIImage imageNamed:@"ShouldFlex4.jpg"],[UIImage imageNamed:@"ShouldFlex4.jpg"], nil];*/
    
    
    self.imgview.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"shoulderFlexion1.jpg"],[UIImage imageNamed:@"shoulderFlexion2.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion3.jpg"],[UIImage imageNamed:@"shoulderFlexion4.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion5.jpg"],[UIImage imageNamed:@"shoulderFlexion6.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion7.jpg"],[UIImage imageNamed:@"shoulderFlexion8.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion9.jpg"],[UIImage imageNamed:@"shoulderFlexion10.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion11.jpg"],[UIImage imageNamed:@"shoulderFlexion12.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion13.jpg"],[UIImage imageNamed:@"shoulderFlexion14.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion15.jpg"],[UIImage imageNamed:@"shoulderFlexion16.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion17.jpg"],[UIImage imageNamed:@"shoulderFlexion18.jpg"],
                                    [UIImage imageNamed:@"shoulderFlexion19.jpg"],[UIImage imageNamed:@"shoulderFlexion20.jpg"],nil];

    
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

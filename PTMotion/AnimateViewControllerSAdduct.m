//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerSAdduct.h"

@interface AnimateViewControllerSAdduct ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerSAdduct
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
        
        [self performSegueWithIdentifier:@"sadduct" sender:self];
        
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
    
    //Shoulder Adduction
        
        //Should be changed once videos are recorded
        //self.textDisplay.text = @"1. Extend your arm, and hold the device with the screen face up.\n2. When the countdown begins, rotate your wrist.\n3. Repeat.";
    
    self.textDisplay.text = @"1. Hold the phone downwards in the hand.\n\n 2. It should be facing the direction your body faces when looking forward. \n\n 3. Then, raise the whole arm up to above your head.";
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
       /* self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"ShouldAbduct1.jpg"],[UIImage imageNamed:@"ShouldAbduct1.jpg"],
                                        [UIImage imageNamed:@"ShouldAbduct2.jpg"],[UIImage imageNamed:@"ShouldAbduct2.jpg"],
                                        [UIImage imageNamed:@"ShouldAbduct3.jpg"],[UIImage imageNamed:@"ShouldAbduct3.jpg"],
                                        [UIImage imageNamed:@"ShouldAbduct4.jpg"],[UIImage imageNamed:@"ShouldAbduct4.jpg"], nil]; */
    
    
    self.imgview.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"shoulderAdduction1.jpg"],[UIImage imageNamed:@"shoulderAdduction2.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction3.jpg"],[UIImage imageNamed:@"shoulderAdduction4.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction5.jpg"],[UIImage imageNamed:@"shoulderAdduction6.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction7.jpg"],[UIImage imageNamed:@"shoulderAdduction8.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction9.jpg"],[UIImage imageNamed:@"shoulderAdduction10.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction11.jpg"],[UIImage imageNamed:@"shoulderAdduction12.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction13.jpg"],[UIImage imageNamed:@"shoulderAdduction14.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction15.jpg"],[UIImage imageNamed:@"shoulderAdduction16.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction17.jpg"],[UIImage imageNamed:@"shoulderAdduction18.jpg"],
                                    [UIImage imageNamed:@"shoulderAdduction19.jpg"],[UIImage imageNamed:@"shoulderAdduction20.jpg"], nil];
    
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

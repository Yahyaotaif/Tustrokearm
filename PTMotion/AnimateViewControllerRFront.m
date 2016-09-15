//
//  AnimateViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 6/22/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "AnimateViewControllerRFront.h"

@interface AnimateViewControllerRFront ()
@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong, nonatomic) IBOutlet UITextView *textDisplay;

@end

@implementation AnimateViewControllerRFront
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
        
        [self performSegueWithIdentifier:@"rfront" sender:self];
        
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
    
    
   //Elbow Raise to  Front
     
        self.textDisplay.text = @"1. Hold device to your side with screen facing you with elbow at hip, bent at 45 degrees.\n2. At “Start”, raise device straight up, extending your arm.\n3. Repeat.";

    
        self.imgview = [[UIImageView alloc]
                        initWithFrame:CGRectMake(10, 10, 300, 400)];
        // set an animation
        self.imgview.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"elbowRaiseFront1.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront2.jpg"],[UIImage imageNamed:@"elbowRaiseFront3.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront4.jpg"],[UIImage imageNamed:@"elbowRaiseFront5.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront6.jpg"],[UIImage imageNamed:@"elbowRaiseFront7.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront8.jpg"],[UIImage imageNamed:@"elbowRaiseFront9.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront10.jpg"], [UIImage imageNamed:@"elbowRaiseFront11.jpg"],[UIImage imageNamed:@"elbowRaiseFront12.jpg"],[UIImage imageNamed:@"elbowRaiseFront13.jpg"],[UIImage imageNamed:@"elbowRaiseFront14.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront15.jpg"],[UIImage imageNamed:@"elbowRaiseFront16.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront17.jpg"],[UIImage imageNamed:@"elbowRaiseFront18.jpg"],
                                        [UIImage imageNamed:@"elbowRaiseFront19.jpg"],[UIImage imageNamed:@"elbowRaiseFront20.jpg"],nil];
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

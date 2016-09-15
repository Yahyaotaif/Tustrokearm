//
//  MainMenuViewController.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "MainMenuViewController.h"

// view controllers
#import "PTGameViewController.h"

// misc
#import "AppDelegate.h"

@interface MainMenuViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *gameTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *fRotateComp;
@property (weak, nonatomic) IBOutlet UILabel *fRotateGoal;

@property (weak, nonatomic) IBOutlet UILabel *eFlexionComp;
@property (weak, nonatomic) IBOutlet UILabel *eFlexionGoal;

@property (weak, nonatomic) IBOutlet UILabel *eRaiseFComp;
@property (weak, nonatomic) IBOutlet UILabel *eRaiseFGoal;

@property (weak, nonatomic) IBOutlet UILabel *eRaiseSComp;
@property (weak, nonatomic) IBOutlet UILabel *eRaiseSGoal;

@property (weak, nonatomic) IBOutlet UILabel *sFlexionComp;
@property (weak, nonatomic) IBOutlet UILabel *sFlexionGoal;

@property (weak, nonatomic) IBOutlet UILabel *sRotateComp;
@property (weak, nonatomic) IBOutlet UILabel *sRotateGoal;

@property (weak, nonatomic) IBOutlet UILabel *hsRotateGoal;
@property (weak, nonatomic) IBOutlet UILabel *hsRotateComp;

@property (weak, nonatomic) IBOutlet UILabel *sAdductGoal;
@property (weak, nonatomic) IBOutlet UILabel *sAdductComp;



@end

@implementation MainMenuViewController
+ (BOOL)isFirstTime{
    static BOOL flag=NO;
    static BOOL result;
    if(!flag){
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunchedOnce"])
        {
            result=NO;
        }
        else
        {   //If it's the first time being launched, it sets the defaults to the default angle measurements
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnceDG"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            result=YES;
            
            
            NSLog(@"The first time running is Settings");
            
            [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
            NSLog(@"The playing hand is right");
            
            [[NSUserDefaults standardUserDefaults] setInteger: 1 forKey:@"animateBut"];
            NSLog(@"The animate button is on.");
            
        }
        
        flag=YES;
    }
    return result;}

- (IBAction)gameTypeChange:(id)sender {
    
    
   
    if(self.gameTypeSegmentedControl.isEnabled){
        [[NSUserDefaults standardUserDefaults] setBool: true forKey:  @"gameType"];
        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool: false forKey:  @"gameType"];
        
    }
    

}
#pragma mark - Navigation
-(void) viewDidLoad{
    
    /*NSString *title = NSLocalizedString(@"Notice!", @"title");
    NSString *message = NSLocalizedString(@" Make sure you warm up before performing the exercises. \n\nIf you start to feel any discomfort please stop and call your physician.", @"message");
  
     UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];*/
     
    // UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 40, 40)];
     
    
    
    
    //[bkgImg release];
    //[path release];
    
   //[successAlert addSubview:imageView];
    //[imageView release];
    
    //[successAlert show];
    //[successAlert release];
    
    
    

    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"horizStop"];

    NSUInteger x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
    NSString *number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateGoal.text = number1;
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"fRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionGoal.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFComp.text = number1;
    ///////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRScompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSComp.text = number1;
    /////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionComp.text = number1;
    //////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateComp.text = number1;
    ///////////////////
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateComp.text = number1;
    //hsRotateComp;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sAcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductComp.text = number1;
    //sAdduct

    

    [super viewDidLoad];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = [segue destinationViewController];
    if ([viewController isKindOfClass:[PTGameViewController class]]) {
        PTGameViewController *gameViewController = (PTGameViewController *) viewController;
        gameViewController.gameType = self.gameTypeSegmentedControl.selectedSegmentIndex;
    }
    
    if(self.gameTypeSegmentedControl.selectedSegmentIndex == PTGameTypeMonkey){
        [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:  @"gameType"];
        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setInteger: 1 forKey:  @"gameType"];
        
    }
    
    
    
}

#pragma mark - Actions

- (IBAction)logoutButtonPressed:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate logout];
}


-(void) updateHelper{
    
    NSUInteger x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
    NSString *number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateGoal.text = number1;
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"fRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionGoal.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFComp.text = number1;
    ///////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRScompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSComp.text = number1;
    /////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionComp.text = number1;
    //////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateComp.text = number1;
    ///////////////////
    
    ///////////////////
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateComp.text = number1;
    //hsRotateComp;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sAcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductComp.text = number1;
    //sAdduct

    

}

-(void)viewDidAppear:(BOOL)animated{
    NSUInteger x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
    NSString *number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateGoal.text = number1;
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"fRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.fRotateComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionGoal.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eFlexionComp.text = number1;//
    ////////////
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseFComp.text = number1;
    ///////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRScompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.eRaiseSComp.text = number1;
    /////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sFlexionComp.text = number1;
    //////////////////
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateGoal.text = number1;
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sRotateComp.text = number1;
    ///////////////////
    
    ///////////////////
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"hRcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.hsRotateComp.text = number1;
    //hsRotateComp;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductGoal.text = number1;
    
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"sAcompCount"];
    number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
    self.sAdductComp.text = number1;
    //sAdduct

    

}

@end

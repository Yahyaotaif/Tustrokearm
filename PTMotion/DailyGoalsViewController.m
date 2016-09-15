//
//  DailyGoalsViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 4/19/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DailyGoalsViewController.h"
#import "MainMenuViewController.h"
#import "DailyGoals.h"
#import "TUHTTPSessionManager.h"
// misc
#import "SVProgressHUD.h"
@interface DailyGoalsViewController ()

@property (nonatomic, strong) DailyGoals *goals;




@property (weak, nonatomic) IBOutlet UITextField *fRTNum;
@property (weak, nonatomic) IBOutlet UITextField *fRTLength;

@property (weak, nonatomic) IBOutlet UITextField *eFTLength;
@property (weak, nonatomic) IBOutlet UITextField *eFTNum;

@property (weak, nonatomic) IBOutlet UITextField *eRFTNum;
@property (weak, nonatomic) IBOutlet UITextField *eRFTLength;

@property (weak, nonatomic) IBOutlet UITextField *eRSTLength;
@property (weak, nonatomic) IBOutlet UITextField *eRSTNum;

@property (weak, nonatomic) IBOutlet UITextField *sFTLength;
@property (weak, nonatomic) IBOutlet UITextField *sFTNum;

@property (weak, nonatomic) IBOutlet UITextField *sRTNum;
@property (weak, nonatomic) IBOutlet UITextField *sRTLength;

@property (weak, nonatomic) IBOutlet UITextField *hRTNum;
@property (weak, nonatomic) IBOutlet UITextField *hRTLength;

@property (weak, nonatomic) IBOutlet UITextField *sATNum;
@property (weak, nonatomic) IBOutlet UITextField *sATLength;


@property (weak, nonatomic) IBOutlet UITextView *Notes;
@end

@implementation DailyGoalsViewController

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
            
            /*[[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"fRTLength"];
            
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"fRTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"eFTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eFTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"eRFTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRFTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"eRSTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRSTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"sFTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sFTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"sRTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sRTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"hRTNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"hRTLength"];
            [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sATNum"];
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"sATLength"];
            */
            
            [[NSUserDefaults standardUserDefaults] setObject: @"" forKey:@"NotesDG"];

            NSLog(@"The first time running is Daily Goals");
            
            
            
        }
        
        flag=YES;
    }
    return result;}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"This executed first");
    
    
    
    if([DailyGoalsViewController isFirstTime]){
        self.goals = [[DailyGoals alloc]init];

        NSLog(@"The first caliDefault tries to launch");
        //Setting Defaults
        NSUInteger x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"];
        NSString *number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        
        NSLog(@"The value1 is %lu",(unsigned long)x);
        self.fRTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.fRTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eFTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eFTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eRFTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eRFTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eRSTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.eRSTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sFTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sFTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sRTLength.text = number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sRTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.hRTNum.text= number1;
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.hRTLength.text= number1;
       
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sATNum.text= number1;
        
        
        x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sATLength"];
        number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
        self.sATLength.text= number1;
       
        self.Notes.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"NotesDG"];

    }
        else{
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"dailyGoals1"];
            self.goals = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSUInteger x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"];
            NSString *number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            
            NSLog(@"The value1 is %lu",(unsigned long)x);
            self.fRTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.fRTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eFTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eFTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eRFTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eRFTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eRSTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.eRSTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sFTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sFTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sRTLength.text = number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sRTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.hRTNum.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.hRTLength.text= number1;
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sATNum.text= number1;
            
            
            x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sATLength"];
            number1 = [[NSString alloc] initWithFormat: @"%lu",(unsigned long)x];
            self.sATLength.text= number1;
            
             self.Notes.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"NotesDG"];

        }
        
       // [self updateData];
       // [self reloadView];
    //self.data = [NSKeyedArchiver archivedDataWithRootObject:self.goals];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.data forKey:@"dailyGoals1"];
        NSLog(@"The first one was launched");
    }
/*
- (void)updateData
{
    
    integer_t x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"];
    NSString *number1 = [[NSString alloc] initWithFormat: @"%d",x];
    
    NSLog(@"The value1 is %d",x);
    self.fRTLength.text = number1;
    self.fRTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
    
    self.eFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"];
    
    self.eFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    
    self.eRFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"];
    
    self.eRFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    
    self.eRSTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"];
    self.eRSTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    
    self.sFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"];
    self.sFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    
    self.sRTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"];
    self.sRTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];

}


-(void) resignKey:(id) sender{
    
}*/
/*
- (void)reloadData
{
    self.fRTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"];
    
    self.fRTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
    
    self.eFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"];
    
    self.eFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    
    self.eRFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"];
    
    self.eRFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    
    self.eRSTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"];
    self.eRSTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    
    self.sFTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"];
    self.sFTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    
    self.sRTLength.text = @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"];
    self.sRTNum.text= @"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];

}*/

/*- (void)reloadView
{//The method that manages the value update
    integer_t x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"];
    NSString *number1 = [[NSString alloc] initWithFormat: @"%d",x];
    
    NSLog(@"The value1 is %d",x);
    self.fRTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"];
   number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.fRTNum.text= number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eFTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eFTNum.text= number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eRFTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eRFTNum.text= number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eRSTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.eRSTNum.text= number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.sFTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.sFTNum.text= number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.sRTLength.text = number1;
    
    x =[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"];
    number1 = [[NSString alloc] initWithFormat: @"%d",x];
    self.sRTNum.text= number1;

}*/

- (IBAction)saveButton:(id)sender {
    
    
    
    
    
    NSUInteger number = [self.fRTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"fRTLength"];
    self.goals.fRTLength = number;
    number = [self.fRTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"fRTNum"];
    self.goals.fRTNum = number;
    number = [self.eFTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eFTLength"];
    self.goals.eFTLength = number;
    number = [self.eFTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eFTNum"];
    self.goals.eFTNum = number;
    number = [self.eRFTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eRFTLength"];
    self.goals.eRFTLength = number;
    number = [self.eRFTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eRFTNum"];
    self.goals.eRFTNum = number;
    number = [self.eRSTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eRSTLength"];
    self.goals.eRSTLength = number;
    number = [self.eRSTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"eRSTNum"];
    self.goals.eRSTNum = number;
    
    number = [self.sFTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sFTLength"];
    self.goals.sFTLength = number;
    number = [self.sFTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sFTNum"];
    self.goals.sFTNum = number;
    number = [self.sRTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sRTLength"];
    self.goals.sRTLength = number;
    number = [self.sRTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sRTNum"];
    self.goals.sRTNum = number;
    
    number = [self.hRTNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"hRTNum"];
    self.goals.hRTNum = number;
    
    number = [self.hRTLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"hRTLength"];
    self.goals.hRTLength = number;
    
    number = [self.sATNum.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sATNum"];
    self.goals.sATNum = number;
    
    number = [self.sATLength.text integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger: number forKey:@"sATLength"];
    self.goals.sATLength = number;
    
     [[NSUserDefaults standardUserDefaults] setObject: self.Notes.text forKey:@"NotesDG"];
    //The code above saves the data to the default settings and the daily goals variable
    
    self.goals.patientId = @"yes";
    self.goals.hand =[[NSUserDefaults standardUserDefaults] floatForKey:@"playingHand"]+1 ;
    //(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"pId"];
    NSLog(@"THe save button pressed %lu",(unsigned long)number);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    //The SVp shows  the loading circle
    [[TUHTTPSessionManager sessionManager] saveDailyGoals:self.goals completion:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"The server if ran!");
        } else if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
    //Connects to the database with the dailygoal variables
    
}



@end



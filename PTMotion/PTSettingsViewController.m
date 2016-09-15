//
//  PTSettingsViewController.m
//  ARMStrokes
//
//  Created by Ted Smith on 4/15/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTSettingsViewController.h"


@interface PTSettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *leftRight;

@property (strong, nonatomic) IBOutlet UISwitch *animateBut;



- (IBAction)switchPressed:(id)sender;

@end

@implementation PTSettingsViewController
- (IBAction)changeAnimateBut:(id)sender {
    
    if(self.animateBut.on){
        [[NSUserDefaults standardUserDefaults] setInteger: 1 forKey:@"animateBut"];
        NSLog(@"The animate button is on");
    }
    else{
        [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"animateBut"];
        NSLog(@"The animate button is off");
    }
    

}

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
            
            [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"animateBut"];
            NSLog(@"The animate button is on.");
            
        }
        
        flag=YES;
    }
    return result;}

- (void)viewDidLoad
{
    if([[NSUserDefaults standardUserDefaults] floatForKey:@"playingHand"]==1){
        self.leftRight.on=true;
    }
    else{
        self.leftRight.on=false;
    }
    
    if([[NSUserDefaults standardUserDefaults] floatForKey:@"animateBut"]==1){
        self.animateBut.on=true;
    }
    else{
        self.animateBut.on=false;
    }
    [super viewDidLoad];
    NSLog(@"This executed first");
    
    
}

- (IBAction)saveButton:(id)sender {
    if(self.leftRight.on){
        [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        NSLog(@"The playing hand is right");
    }
    else{
        [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        NSLog(@"The playing hand is left");
    }
    
    if(self.animateBut.on){
        [[NSUserDefaults standardUserDefaults] setInteger: 1 forKey:@"animateBut"];
        NSLog(@"The animate button is on");
    }
    else{
        [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"animateBut"];
        NSLog(@"The animate button is off");
    }
 
}
-(void)viewDidAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults] floatForKey:@"playingHand"]==1){
        self.leftRight.on=true;
    }
    else{
        self.leftRight.on=false;
    }
    [super viewDidLoad];
    NSLog(@"The view appeared on settings");
}

- (IBAction)switchPressed:(id)sender {
    if(self.leftRight.on){
       // [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];
        NSLog(@"The playing hand is right");
    }
    else{
        //[[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"playingHand"];
        NSLog(@"The playing hand is left");
    }
}
@end



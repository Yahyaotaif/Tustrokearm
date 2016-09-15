//
//  LoginViewController.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "LoginViewController.h"

// TU
#import "TUHTTPSessionManager.h"

// misc
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

// ui
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) IBOutlet UITableViewCell *loginCell;

@property (nonatomic, weak) IBOutlet UITextView *notice;

@end

@implementation LoginViewController

#pragma mark - View controller

- (void)viewWillAppear:(BOOL)animated
{
    [LoginViewController isFirstTime];
    [super viewWillAppear:animated];
    self.notice.text=@" \t\t\t\t\t NOTICE\n\nMake sure you warm up before performing the exercises. If you start to feel any discomfort please stop and call your physician.";
    // precompose user login form
    [self recoverUserDefaults];
}

#pragma mark - User defaults

- (void)recoverUserDefaults
{
    self.usernameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kDefaultsUsernameKey];
    self.passwordTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kDefaultsPasswordKey];
}

- (void)persistsUserDefaultsWithUsername:(NSString *)username password:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kDefaultsUsernameKey];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kDefaultsPasswordKey];
}

#pragma mark - Operations

- (void)attemptLoginOperation
{
    NSError *error;
    if ([self canLogin:&error]) {
        [self loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    } else if (error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription] maskType:SVProgressHUDMaskTypeGradient];
    }
}

- (BOOL)canLogin:(NSError **)error
{
    BOOL proceed = YES;
    
    // error check for uname & pword
    if (!self.usernameTextField.text || [self.usernameTextField.text length] == 0) {
        proceed = NO;
        
        if (error != NULL) {
            NSString *errorString = @"You must enter a username in order to login.";
            *error = [NSError errorWithDomain:@"TU" code:100 userInfo:@{ NSLocalizedDescriptionKey : errorString }];
        }
    } else if (!self.passwordTextField.text || [self.passwordTextField.text length] == 0) {
        proceed = NO;
        
        if (error != NULL) {
            NSString *errorString = @"You must enter a password in order to login.";
            *error = [NSError errorWithDomain:@"TU" code:101 userInfo:@{ NSLocalizedDescriptionKey : errorString }];
        }
    }
    
    return proceed;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [SVProgressHUD show];
    
    [[TUHTTPSessionManager sessionManager] loginWithUsername:username password:password completion:^(BOOL success, NSError *error) {
        if (success) {
            [self persistsUserDefaultsWithUsername:username password:password]; // save default successful login info
            [SVProgressHUD dismiss]; // ui cleanup
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil]; // alert listeners
            
            NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey: @"recentDate"];
            if(object==nil){
                NSDate *today = [NSDate date];
                [[NSUserDefaults standardUserDefaults] setObject:today forKey:@"recentDate"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"fRcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eFcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRFcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRScompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sFcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sRcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"hRcompCount"];
                [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sAcompCount"];
                //[[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"playingHand"];

                NSLog(@"Today date is nil");
            }
            else{
                NSDate *today = [NSDate date];
                NSDate *recent = [[NSUserDefaults standardUserDefaults] objectForKey: @"recentDate"];
                NSCalendar *gregorian = [NSCalendar currentCalendar];
                unsigned unitFlags = NSCalendarUnitDay;
                NSDateComponents *comps = [gregorian components:unitFlags fromDate:today];
                [comps setHour: 0];
                [comps setMinute: 0];
                [comps setSecond: 0];
                today = [gregorian dateFromComponents: comps];
                comps = [gregorian components:unitFlags fromDate:recent];
                [comps setHour: 0];
                [comps setMinute: 0];
                [comps setSecond: 0];
                recent = [gregorian dateFromComponents: comps];
                
                if([today isEqualToDate:recent]){
                    NSLog(@"the current date is equal to the recent");
                }
                else{
                    [[NSUserDefaults standardUserDefaults] setObject:today forKey:@"recentDate"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"fRcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eFcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRFcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"eRScompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sFcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sRcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"hRcompCount"];
                    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey:@"sAcompCount"];
                    NSLog(@"the current date is different from recent");
                    NSLog(@"current is %@ and the recent is %@",today,recent);
                }
            }

            [self getDate];
        } else if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription] maskType:SVProgressHUDMaskTypeGradient];
        }
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.loginCell) {
        [self attemptLoginOperation];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)getDate{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate: today];
    NSLog(@"date: %@",dateString);
}
/*
-(NSUinteger) daysBetweenDate:(NSDate *)firstDate andDate: (NSDate *)secondDate{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    unsigned unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:firstDate];
    [comps setHour: 0];
    [comps setMinute: 0];
    [comps setSecond: 0];
    firstDate = [gregorian dateFromComponents: comps];
    comps = [gregorian components:unitFlags fromDate:secondDate];
    [comps setHour: 0];
    [comps setMinute: 0];
    [comps setSecond: 0];
    secondDate = [gregorian dateFromComponents: comps];
    
    
}*/
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
            
            [[NSUserDefaults standardUserDefaults] setInteger: 30 forKey:@"fRTLength"];
            
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
            
            
            [[NSUserDefaults standardUserDefaults] setObject: @"" forKey:@"NotesDG"];
            
            NSLog(@"The first time running is Daily Goals");
            
            
            
        }
        
        flag=YES;
    }
    return result;}

@end

//
//  SignupViewController.m
//  PTMotion
//
//  Created by David Messing on 1/5/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "SignupViewController.h"

// TU
#import "TUHTTPSessionManager.h"

// misc
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface SignupViewController ()

// ui
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *confirmPasswordTextField;

@property (nonatomic, weak) IBOutlet UITableViewCell *signupCell;

@end

@implementation SignupViewController

#pragma mark - User defaults

- (void)persistsUserDefaultsWithUsername:(NSString *)username password:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kDefaultsUsernameKey];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kDefaultsPasswordKey];
}

#pragma mark - Operations

- (void)attemptSignupOperation
{
    NSError *error;
    if ([self canSignup:&error]) {
        [self signupWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    } else if (error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription] maskType:SVProgressHUDMaskTypeGradient];
    }
}

- (BOOL)canSignup:(NSError **)error
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
    } else if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        proceed = NO;
        
        if (error != NULL) {
            NSString *errorString = @"Passwords don't match.";
            *error = [NSError errorWithDomain:@"TU" code:102 userInfo:@{ NSLocalizedDescriptionKey : errorString }];
        }
    }
    
    return proceed;
}

- (void)signupWithUsername:(NSString *)username password:(NSString *)password
{
    [SVProgressHUD show];
    
    [[TUHTTPSessionManager sessionManager] signupWithUsername:username password:password completion:^(BOOL success, NSError *error) {
        if (success) {
            [self persistsUserDefaultsWithUsername:username password:password]; // save default successful login info
            [SVProgressHUD dismiss]; // ui cleanup
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil]; // alert listeners
        } else if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription] maskType:SVProgressHUDMaskTypeGradient];
        }
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.signupCell) {
        [self attemptSignupOperation];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

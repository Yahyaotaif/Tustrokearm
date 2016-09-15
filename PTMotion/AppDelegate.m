//
//  AppDelegate.m
//  PTMotion
//
//  Created by David Messing on 10/19/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "AppDelegate.h"

// misc
#import "AFNetworkActivityLogger.h"

// App Constants
NSString * const kMainStoryboard = @"Main";
NSString * const kMainMenuNavigationController = @"MainMenuNavigationController";
NSString * const kLoginNavigationController = @"LoginNavigationController";

NSString * const kLoginNotification = @"kLoginNotification";
NSString * const kLoginNotificationUserKey = @"kLoginNotificationUserKey";

NSString * const kDefaultsUsernameKey    = @"username";
NSString * const kDefaultsPasswordKey    = @"password";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // log networking traffic
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelInfo];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    // register for local notifications
    [self registerNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self unregisterNotifications];
}

#pragma mark - Notifications

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:kLoginNotification object:nil];
}

- (void)notificationReceived:(NSNotification *)note
{
    if ([[note name] isEqualToString:kLoginNotification]) {
        // TODO: capture session key
        
        // present main menu
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboard bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:kMainMenuNavigationController];
        [self transitionToViewController:viewController withTransition:UIViewAnimationOptionTransitionFlipFromRight];
    }
}

- (void)unregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginNotification object:nil];
}

#pragma mark - Operations

- (void)logout
{
    // TODO: remove session key
    
    // clear user defaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultsUsernameKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultsPasswordKey];
    
    // present login screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboard bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:kLoginNavigationController];
    [self transitionToViewController:viewController withTransition:UIViewAnimationOptionTransitionFlipFromLeft];
}

#pragma mark - Window animation

- (void)transitionToViewController:(UIViewController *)viewController
                    withTransition:(UIViewAnimationOptions)transition
{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:viewController.view
                      duration:0.65f
                       options:transition
                    completion:^(BOOL finished){
                        self.window.rootViewController = viewController;
                    }];
}

@end

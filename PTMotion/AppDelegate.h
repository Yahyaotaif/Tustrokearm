//
//  AppDelegate.h
//  PTMotion
//
//  Created by David Messing on 10/19/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import <UIKit/UIKit.h>

// App Constants
extern NSString * const kLoginNotification;
extern NSString * const kLoginNotificationUserKey;

extern NSString * const kDefaultsUsernameKey;
extern NSString * const kDefaultsPasswordKey;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)logout;

@end


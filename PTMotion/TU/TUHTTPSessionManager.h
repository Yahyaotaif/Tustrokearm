//
//  TUHTTPSessionManager.h
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class TUPatient;
@class TUPatientCalibration;
@class TUSession;
@class DailyGoals;
@interface TUHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, strong, readonly) TUPatient *currentUser;

+ (instancetype)sessionManager;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL success, NSError *error))completion;
- (void)signupWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL success, NSError *error))completion;
- (void)savePatient:(TUPatient *)patient completion:(void (^)(BOOL success, NSError *error))completion;
- (void)saveCalibration:(TUPatientCalibration *)calibration completion:(void (^)(BOOL success, NSError *error))completion;
- (void)saveDailyGoals:(DailyGoals *)dailyG completion:(void (^)(BOOL success, NSError *error))completion;
- (void)getDailyData;
- (void)runDailyGoal: completion1:(void (^)(BOOL success, NSError *error))completion1;
- (void)saveSessionResults:(TUSession *)session completion:(void (^)(BOOL success, NSError *error))completion;

@end

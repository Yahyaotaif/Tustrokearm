//
//  TUHTTPSessionManager.m
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "TUHTTPSessionManager.h"
#import "AFNetworking.h"
#import "TUAppLogin.h"
#import "TUPatient.h"
#import "TUPatientCalibration.h"
#import "TUSession.h"
#import "DailyGoals.h"
// consts
static NSString * const kBaseUrl                = @"http://tustroketech.com/webpage/php/";
static NSString * const kLoginParamName         = @"name";
static NSString * const kLoginParamPassword     = @"password";

static NSString * const kPatientId              = @"patientId";
static NSString * const kHandId                 = @"hand";
static NSString * const myBaseUrl                = @"http://teddytestit.com/";

@interface TUHTTPSessionManager ()

@property (nonatomic, strong, readwrite) TUPatient *currentUser;

@end

@implementation TUHTTPSessionManager

#pragma mark - Initialization

+ (instancetype)sessionManager
{
    static TUHTTPSessionManager *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    });
    
    return _instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    return self;
}

#pragma mark - Operations

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL success, NSError *error))completion
{
    NSDictionary *parameters = @{kLoginParamName: username, kLoginParamPassword: password};
    
    [self POST:@"applogin.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             NSError *error;
             TUAppLogin *login = [[TUAppLogin alloc] initWithDictionary:responseObject error:&error];
             if (error) {
                 if (completion) { completion(NO, error); }
             } else if (login) {
                 if ([login.status isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : login.message }];
                         completion(NO, error);
                     }
                 } else if ([login.status isEqualToString:@"success"]) {
                     self.currentUser = login.patient;
                     if (completion) {
                         
                         completion(YES, nil);
                         //////////////////////////////
                         NSLog(@"Before the run daily goal");
                         [self runDailyGoal:self.currentUser.patientId completion1:^(BOOL success, NSError *error){
                             if(success){
                                 completion(YES,nil);
                             }
                             else if(error){
                                 completion(NO,error);
                             }
                         }];
                          NSLog(@"After the run daily goal");
                         [self getDailyData];
                         NSLog(@"After the get daily goal");
                          /////////////////////////////
                     }
                 }
             } else {
                 if (completion) {
                     NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Failed to parse responseObject. Please contact an administrator for help." }];
                     completion(NO, error);
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) { completion(NO, error); }
     }];
}

- (void)signupWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL success, NSError *error))completion
{
    NSDictionary *parameters = @{kLoginParamName: username, kLoginParamPassword: password};
    
    [self POST:@"patient.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             NSError *error;
             TUAppLogin *login = [[TUAppLogin alloc] initWithDictionary:responseObject error:&error];
             if (error) {
                 if (completion) { completion(NO, error); }
             } else if (login) {
                 if ([login.status isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : login.message }];
                         completion(NO, error);
                     }
                 } else if ([login.status isEqualToString:@"success"]) {
                     self.currentUser = login.patient;
                     if (completion) { completion(YES, nil); }
                 }
             } else {
                 if (completion) {
                     NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Failed to parse responseObject. Please contact an administrator for help." }];
                     completion(NO, error);
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) { completion(NO, error); }
     }];
}

- (void)savePatient:(TUPatient *)patient completion:(void (^)(BOOL success, NSError *error))completion
{
    NSDictionary *parameters = [patient toDictionary];
    
    [self POST:@"patient.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             if ([responseObject objectForKey:@"status"]) {
                 NSString *string = [responseObject objectForKey:@"status"];
                 if ([string isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred." }];
                         completion(NO, error);
                     }
                 } else if ([string isEqualToString:@"success"]) {
                     if (completion) { completion(YES, nil); }
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) { completion(NO, error); }
     }];
}

- (void)saveCalibration:(TUPatientCalibration *)calibration completion:(void (^)(BOOL success, NSError *error))completion
{
    NSDictionary *parameters = [calibration toDictionary];
    NSLog(@" The save cali made it %@", [parameters objectForKey:@"horizRotateLowValue"]);
    [self POST:@"calibration.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             if ([responseObject objectForKey:@"status"]) {
                 NSString *string = [responseObject objectForKey:@"status"];
                 if ([string isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred." }];
                         completion(NO, error);
                     }
                 } else if ([string isEqualToString:@"success"]) {
                     if (completion) {
                         NSLog(@"It ran to completion");
                         completion(YES, nil);
                     }
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Did it fail");
         if (completion) { completion(NO, error); }
     }];
}


- (void)saveDailyGoals:(DailyGoals *)dailyG completion:(void (^)(BOOL success, NSError *error))completion
{
    dailyG.patientId = self.currentUser.patientId;
    NSDictionary *parameters = [dailyG toDictionary];
    //NSLog(@" The save cali made it %@", [parameters objectForKey:@"elbowFlexionLoweredValue"]);
    [self POST:@"dailyTask.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             if ([responseObject objectForKey:@"status"]) {
                 NSString *string = [responseObject objectForKey:@"status"];
                 if ([string isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred." }];
                         completion(NO, error);
                     }
                 } else if ([string isEqualToString:@"success"]) {
                     if (completion) {
                         NSLog(@"It ran to completion");
                         completion(YES, nil);
                     }
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Did it fail");
         if (completion) { completion(NO, error); }
     }];
}

- (void)saveSessionResults:(TUSession *)session completion:(void (^)(BOOL success, NSError *error))completion
{
    session.patientId = self.currentUser.patientId;
    NSDictionary *parameters = [session toDictionary];

    [self POST:@"session.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion(NO, error);
             }
         } else {
             if ([responseObject objectForKey:@"status"]) {
                 NSString *string = [responseObject objectForKey:@"status"];
                 if ([string isEqualToString:@"error"]) {
                     if (completion) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred." }];
                         completion(NO, error);
                     }
                 } else if ([string isEqualToString:@"success"]) {
                     if (completion) { completion(YES, nil); }
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) { completion(NO, error); }
     }];
}

-(void) getDailyData{
    __block NSDictionary *myDiction = nil;
    __block NSDictionary *myDiction2 = nil;
    // 1
    NSString *string = [NSString stringWithFormat:@"%@data.json", kBaseUrl];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        myDiction = (NSDictionary *)responseObject;
       // self.title = @"JSON Retrieved";
        NSLog(@"Made it to 3");
        NSString *teddyVar = myDiction[@"Smith"];
        NSLog(@"The value from the json thing @Smith %@",teddyVar);
        NSString *teddyVar2 = myDiction[@"Name"];
        NSLog(@"The value from the json thing @Name %@",teddyVar2);
        /*
         
         I will use this area to take the variables to sync up with the built in data.
        NSString *e0N = myDiction[@"e0N"];
        int e0NI = [e0N integerValue];
         
        NSString *e1N = myDiction[@"e1N"];
        int e1NI = [e1N integerValue];
        NSString *e2N = myDiction[@"e2N"];
        int e2NI = [e2N integerValue];
        NSString *e3N = myDiction[@"e3N"];
        int e3NI = [e3N integerValue];
        NSString *e4N = myDiction[@"e4N"];
        int e4NI = [e4N integerValue];
        NSString *e5N = myDiction[@"e5N"];
        int e5NI = [e5N integerValue];
        NSString *e6N = myDiction[@"e6N"];
        int e6NI = [e6N integerValue];
        NSString *e7N = myDiction[@"e7N"];
        int e7NI = [e7N integerValue];
        
        NSString *e0L = myDiction[@"e0L"];
        int e0LI = [e0L integerValue];
        NSString *e1L = myDiction[@"e1L"];
        int e1LI = [e1L integerValue];
        NSString *e2L = myDiction[@"e2L"];
        int e2LI = [e2L integerValue];
        NSString *e3L = myDiction[@"e3L"];
        int e3LI = [e3L integerValue];
        NSString *e4L = myDiction[@"e4L"];
        int e4LI = [e4L integerValue];
        NSString *e5L = myDiction[@"e5L"];
        int e5LI = [e5L integerValue];
        NSString *e6L = myDiction[@"e6L"];
        int e6LI = [e6L integerValue];
        NSString *e7L = myDiction[@"e7L"];
        int e7LI = [e7L integerValue];
         
         if(e0LI == 0){
         
         
         }
         
         else{
            
         [[NSUserDefaults standardUserDefaults] setInteger: e0LI forKey:@"fRTLength"];
         
         [[NSUserDefaults standardUserDefaults] setInteger: e0NI forKey:@"fRTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e1LI forKey:@"eFTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e1NI forKey:@"eFTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e2LI forKey:@"eRFTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e2NI forKey:@"eRFTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e3LI forKey:@"eRSTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e3NI forKey:@"eRSTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e4LI forKey:@"sFTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e4NI forKey:@"sFTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e5LI forKey:@"sRTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e5NI forKey:@"sRTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e6NI forKey:@"hRTNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e6LI forKey:@"hRTLength"];
         [[NSUserDefaults standardUserDefaults] setInteger: e7NI forKey:@"sATNum"];
         [[NSUserDefaults standardUserDefaults] setInteger: e7LI forKey:@"sATLength"];

         
         }
         */
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving DailyGoal Data from Therapist"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    
    
    
}

- (void)runDailyGoal: (NSString *)username completion1:(void (^)(BOOL success, NSError *error))completion1
{
    NSDictionary *parameters = @{kLoginParamName: self.currentUser.patientId};
 
    
    [self POST:@"edit.php"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (!responseObject) {
             if (completion1) {
                 NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"Connection is offline. Please contact an administrator for help." }];
                 completion1(NO, error);
                 NSLog(@"The edit php could not be connected to 1.");
             }
         } else {
             if ([responseObject objectForKey:@"status"]) {
                 NSString *string = [responseObject objectForKey:@"status"];
                 if ([string isEqualToString:@"error"]) {
                     if (completion1) {
                         NSError *error = [NSError errorWithDomain:@"TU" code:200 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred." }];
                         NSLog(@"The edit php could not be connected to 2.");
                         completion1(NO, error);
                     }
                 } else if ([string isEqualToString:@"success"]) {
                     if (completion1) {//The area that is reached the edit.php file is connected to correctly
                         NSLog(@"The edit php could be connected to successfully.");
                         completion1(YES, nil);
                         NSString *teddyVar2 = responseObject[@"Name"];
                         NSLog(@"The value from the json thing @Name %@",teddyVar2);
                         
                         
                         NSString *e0N = responseObject[@"e0N"];
                         if(e0N!=NULL){
                         NSInteger e0NI = [e0N integerValue];
                          NSLog(@"The value from the json thing @e0N %@",e0N);
                         NSString *e1N = responseObject[@"e1N"];
                          NSInteger e1NI = [e1N integerValue];
                         NSLog(@"The value from the json thing @e1N %@",e1N);
                         NSString *e2N = responseObject[@"e2N"];
                          NSInteger e2NI = [e2N integerValue];
                         NSLog(@"The value from the json thing @e2N %@",e2N);
                         NSString *e3N = responseObject[@"e3N"];
                         NSInteger e3NI = [e3N integerValue];
                         NSLog(@"The value from the json thing @e3N %@",e3N);
                         NSString *e4N = responseObject[@"e4N"];
                         NSInteger e4NI = [e4N integerValue];
                         NSLog(@"The value from the json thing @e4N %@",e4N);
                         NSString *e5N = responseObject[@"e5N"];
                         NSInteger e5NI = [e5N integerValue];
                         NSLog(@"The value from the json thing @e5N %@",e5N);
                         NSString *e6N = responseObject[@"e6N"];
                         NSInteger e6NI = [e6N integerValue];
                         NSLog(@"The value from the json thing @e6N %@",e6N);
                         NSString *e7N = responseObject[@"e7N"];
                         NSInteger e7NI = [e7N integerValue];
                         NSLog(@"The value from the json thing @e7N %@",e7N);
                         
                         
                         NSString *e0L = responseObject[@"e0L"];
                          NSInteger e0LI = [e0L integerValue];
                         NSLog(@"The value from the json thing @e0L %@",e0L);
                         NSString *e1L = responseObject[@"e1L"];
                          NSInteger e1LI = [e0L integerValue];
                         NSLog(@"The value from the json thing @e1L %@",e1L);
                         NSString *e2L = responseObject[@"e2L"];
                         NSInteger e2LI = [e2L integerValue];
                         NSLog(@"The value from the json thing @e2L %@",e2L);
                         NSString *e3L = responseObject[@"e3L"];
                         NSInteger e3LI = [e3L integerValue];
                         NSLog(@"The value from the json thing @e3L %@",e3L);
                         NSString *e4L = responseObject[@"e4L"];
                         NSInteger e4LI = [e4L integerValue];
                         NSLog(@"The value from the json thing @e4L %@",e4L);
                         NSString *e5L = responseObject[@"e5L"];
                         NSInteger e5LI = [e5L integerValue];
                         NSLog(@"The value from the json thing @e5L %@",e5L);
                         NSString *e6L = responseObject[@"e6L"];
                         NSInteger e6LI = [e6L integerValue];
                         NSLog(@"The value from the json thing @e6L %@",e6L);
                         NSString *e7L = responseObject[@"e7L"];
                         NSInteger e7LI = [e7L integerValue];
                         NSLog(@"The value from the json thing @e7L %@",e7L);
                         
                         if((e0NI+e1NI+e2NI+e3NI+e4NI+e5NI+e6NI+e7NI!=0)&&(e0LI+e1LI+e2LI+e3LI+e4LI+e5LI+e6LI+e7LI!=0)){
                             if(e0NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e0NI forKey:@"fRTNum"];
                             }
                             if(e0LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e0LI forKey:@"fRTLength"];
                             }
                             if(e1NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e1NI forKey:@"eFTNum"];
                             }
                             if(e1LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e1LI forKey:@"eFTLength"];
                             }
                             if(e2NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e2NI forKey:@"eRFTNum"];
                             }
                             if(e2LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e2LI forKey:@"eRFTLength"];
                             }
                             if(e3NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e3NI forKey:@"eRSTNum"];
                             }
                             if(e3LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e3LI forKey:@"eRSTLength"];
                             }
                             if(e4NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e4NI forKey:@"sFTNum"];
                             }
                             if(e4LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e4LI forKey:@"sFTLength"];
                             }
                             if(e5NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e5NI forKey:@"sRTNum"];
                             }
                             if(e5LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e5LI forKey:@"sRTLength"];
                             }
                             if(e6NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e6NI forKey:@"hRTNum"];
                             }
                             if(e6LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e6LI forKey:@"hRTLength"];
                             }
                             if(e7NI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sATNum"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e7NI forKey:@"sATNum"];
                             }
                             if(e7LI!=[[NSUserDefaults standardUserDefaults] integerForKey:@"sATLength"]){
                                 [[NSUserDefaults standardUserDefaults] setInteger: e7LI forKey:@"sATLength"];
                             }

                         }
                        }


                     }
                 }
             }
         }
     }
       failure:^(NSURLSessionDataTask *task, NSError *error)
     {
          NSLog(@"The edit php straight up failed.");
         if (completion1) { completion1(NO, error); }
     }];
}
@end

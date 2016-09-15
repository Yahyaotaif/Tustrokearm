//
//  PTViewController.m
//  PTMotion
//
//  Created by David Messing on 10/19/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTViewController.h"

static NSTimeInterval const DefaultSessionTime = 30;

@interface PTViewController ()

@property (nonatomic, readwrite) BOOL firstLoad;

@property (nonatomic, strong, readwrite) PTMotionStateContext *motionStateContext;
@property (nonatomic, strong, readwrite) PTSession *session;
@property (nonatomic, strong, readwrite) NSMutableArray *sessionObserverTokens;

@end

@implementation PTViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureSoundEffects];
    [self configureSession];
    [self configureMotionStateContext];
    
    self.firstLoad = YES;
    
    self.patient = [TUHTTPSessionManager sessionManager].currentUser;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self disposeSoundEffects];
    self.session.delegate = nil;
    [self.motionStateContext stopDeviceMotionUpdates];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstLoad) {
        [self presentUserInstructions:animated];
        
        self.firstLoad = NO;
    }
}

#pragma mark - Audio

- (void)configureSoundEffects
{
    // beep
    NSURL *beepURL = [[NSBundle mainBundle] URLForResource:@"beep" withExtension:@"wav"];
    if (beepURL) {
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepURL, &beep);
        if (err != kAudioServicesNoError) {
            NSLog(@"Could no load %@, error code: %d", beepURL, err);
        }
    }
    
    NSURL *toneURL = [[NSBundle mainBundle] URLForResource:@"tone" withExtension:@"wav"];
    if (toneURL) {
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)toneURL, &tone);
        if (err != kAudioServicesNoError) {
            NSLog(@"Could no load %@, error code: %d", toneURL, err);
        }
    }
    
    NSURL *pickupURL = [[NSBundle mainBundle] URLForResource:@"pickup" withExtension:@"wav"];
    if (pickupURL) {
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)pickupURL, &pickup);
        if (err != kAudioServicesNoError) {
            NSLog(@"Could no load %@, error code: %d", pickupURL, err);
        }
    }
}

- (void)disposeSoundEffects
{
    AudioServicesDisposeSystemSoundID(beep);
    AudioServicesDisposeSystemSoundID(tone);
    AudioServicesDisposeSystemSoundID(pickup);
}

#pragma mark - Session

- (void)presentUserInstructions:(BOOL)animated
{
    NSLog(@"Implement %s in concrete class.", __PRETTY_FUNCTION__);
}

- (void)configureSession
{
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==1){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"fRTLength"]];
    }
    
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==2){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"eFTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==3){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"eRFTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==4){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"eRSTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==5){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"sFTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==6){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"sRTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==7){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"hRTLength"]];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"exerciseID"] ==8){
        self.session = [[PTSession alloc] initWithSessionTime:[[NSUserDefaults standardUserDefaults] integerForKey:@"sATLength"]];
    }
    else{
        self.session = [[PTSession alloc] initWithSessionTime:DefaultSessionTime];
    }

    //self.session = [[PTSession alloc] initWithSessionTime:DefaultSessionTime];
    self.session.delegate = self;
    self.sessionObserverTokens = [NSMutableArray array];
}

- (void)configureMotionStateContext
{
    self.motionStateContext = [[PTMotionStateContext alloc] init];
    self.motionStateContext.delegate = self;
}

@end

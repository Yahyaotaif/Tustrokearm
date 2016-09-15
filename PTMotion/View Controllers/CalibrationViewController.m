//
//  CalibrationViewController.m
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "CalibrationViewController.h"

// TU
#import "TUHTTPSessionManager.h"
#import "TUPatient.h"
#import "TUPatientCalibration.h"

// misc
#import "SVProgressHUD.h"

//PTMotionStateContext
#import "PTMotionStateContext.h"

@interface CalibrationViewController ()

@property (nonatomic, strong) TUPatient *patient;
@property (nonatomic, strong) TUPatientCalibration *calibration;


@property (nonatomic, weak) IBOutlet UISegmentedControl *handSegmentedControl;

// vertical
@property (nonatomic, weak) IBOutlet UISlider *verticalUpperSlider;
@property (nonatomic, weak) IBOutlet UILabel *verticalUpperLabel;
@property (nonatomic, weak) IBOutlet UISlider *verticalLowerSlider;
@property (nonatomic, weak) IBOutlet UILabel *verticalLowerLabel;

// roll
@property (nonatomic, weak) IBOutlet UISlider *faceDownRollSlider;
@property (nonatomic, weak) IBOutlet UILabel *faceDownRollLabel;
@property (nonatomic, weak) IBOutlet UISlider *faceUpRollSlider;
@property (nonatomic, weak) IBOutlet UILabel *faceUpRollLabel;
@property (nonatomic, weak) IBOutlet UISlider *rollThresholdSlider;
@property (nonatomic, weak) IBOutlet UILabel *rollThresholdLabel;

// flexion
@property (nonatomic, weak) IBOutlet UISlider *flexionLoweredSlider;
@property (nonatomic, weak) IBOutlet UILabel *flexionLoweredLabel;
@property (nonatomic, weak) IBOutlet UISlider *flexionRaisedSlider;
@property (nonatomic, weak) IBOutlet UILabel *flexionRaisedLabel;
@property (nonatomic, weak) IBOutlet UISlider *flexionThresholdSlider;
@property (nonatomic, weak) IBOutlet UILabel *flexionThresholdLabel;

// abduction
@property (nonatomic, weak) IBOutlet UISlider *abductionLoweredSlider;
@property (nonatomic, weak) IBOutlet UILabel *abductionLoweredLabel;
@property (nonatomic, weak) IBOutlet UISlider *abductionRaisedSlider;
@property (nonatomic, weak) IBOutlet UILabel *abductionRaisedLabel;
@property (nonatomic, weak) IBOutlet UISlider *abductionThresholdSlider;
@property (nonatomic, weak) IBOutlet UILabel *abductionThresholdLabel;
//Elbow FLexion




@property (weak, nonatomic) IBOutlet UISlider *elbowFlexionLowSlider;
@property (weak, nonatomic) IBOutlet UILabel *elbowFlexionLowLabel;


@property (weak, nonatomic) IBOutlet UISlider *elbowFlexionRaiseSlider;

@property (weak, nonatomic) IBOutlet UILabel *elbowFlexionRaiseLabel;


@property (weak, nonatomic) IBOutlet UISlider *elbowFlexionRangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *elbowFlexionRangeLabel;


//Horizontal Shoulder Rotation

@property (weak, nonatomic) IBOutlet UISlider *horizRotateLowSlider;
@property (weak, nonatomic) IBOutlet UILabel *horizRotateLowLabel;


@property (weak, nonatomic) IBOutlet UISlider *horizRotateRaiseSlider;
@property (weak, nonatomic) IBOutlet UILabel *horizRotateRaiseLabel;


@property (weak, nonatomic) IBOutlet UISlider *horizRotateRangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *horizRotateRangeLabel;


//Shoulder Abduction


@property (weak, nonatomic) IBOutlet UILabel *shouldAbductLowLabel;
@property (weak, nonatomic) IBOutlet UISlider *shouldAbductLowSlider;


@property (weak, nonatomic) IBOutlet UILabel *shouldAbductRaiseLabel;
@property (weak, nonatomic) IBOutlet UISlider *shouldAbductRaiseSlider;


@property (weak, nonatomic) IBOutlet UILabel *shouldAbductRangeLabel;
@property (weak, nonatomic) IBOutlet UISlider *shouldAbductRangeSlider;


@end

@implementation CalibrationViewController

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
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            result=YES;
            [[NSUserDefaults standardUserDefaults] setFloat: 5 forKey:@"vertUpSlide"];
            //[[NSUserDefaults standardUserDefaults] setFloat: -5 forKey:@"vertLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceDownSlide"];//Pro Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceUpSlide"];// Sup Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"rollThreshSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"flexLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"flexRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"flexThreshSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 60 forKey:@"abductRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductThreshSlide"];
            //New Addition
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"elbowFlexLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"elbowFlexRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"elbowFlexThreshSlide"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"horizRotateLowSlide"];
             [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"horizRotateRaiseSlide"];
             [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"horizRotateRangeSlide"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"shouldAbductLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"shouldAbductRaiseSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"shouldAbductRangeSlide"];
            
            NSLog(@"The first time running is CalibrationViewController");
            
            //Changes to save for second hand
            [[NSUserDefaults standardUserDefaults] setFloat: 5 forKey:@"vertUpSlide2"];
            //[[NSUserDefaults standardUserDefaults] setFloat: -5 forKey:@"vertLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceDownSlide2"];//Pro Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"faceUpSlide2"];// Sup Angle
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"rollThreshSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"flexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"flexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"flexThreshSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 60 forKey:@"abductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"abductThreshSlide2"];
            //New Addition
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"elbowFlexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"elbowFlexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"elbowFlexThreshSlide2"];
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"horizRotateLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"horizRotateRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"horizRotateRangeSlide2"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: 0 forKey:@"shouldAbductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 90 forKey:@"shouldAbductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: 10 forKey:@"shouldAbductRangeSlide2"];
            
            
            //Hand choice
            [[NSUserDefaults standardUserDefaults] setFloat: 1 forKey:@"hand"];


        }
        
        flag=YES;
    }
    return result;}

+(int)roundUp:(NSNumber *) x{
    int newX = [x intValue];
 
    
    return newX;
}

#pragma mark - View controller

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"This executed first");
    self.patient = [TUHTTPSessionManager sessionManager].currentUser;
    
    [[NSUserDefaults standardUserDefaults] setObject: self.patient.patientId forKey:@"pId"];
    if([CalibrationViewController isFirstTime]){
        self.calibration = [[TUPatientCalibration alloc]init];
        
        //self.caliDefault = [NSUserDefaults standardUserDefaults];
        NSLog(@"The first caliDefault tries to launch");
        //Setting Defaults
        
        if(_handSegmentedControl.selectedSegmentIndex==0){
        
        //
        //Limits, Assign the slider value to the saved values
       // self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
        
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
           
            
         self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
        self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
        self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
            
            
        self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
        self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
        self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];
            
        //Limits
        
        //Next Limits, saves the current slider value to the phone
        [[NSUserDefaults standardUserDefaults] setFloat: self.verticalUpperSlider.value forKey:@"vertUpSlide"];
        //[[NSUserDefaults standardUserDefaults] setFloat: self.verticalLowerSlider.value forKey:@"vertLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceDownRollSlider.value forKey:@"faceDownSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceUpRollSlider.value forKey:@"faceUpSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.rollThresholdSlider.value forKey:@"rollThreshSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionLoweredSlider.value forKey:@"flexLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionRaisedSlider.value forKey:@"flexRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionThresholdSlider.value forKey:@"flexThreshSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionLoweredSlider.value forKey:@"abductLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionRaisedSlider.value forKey:@"abductRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionThresholdSlider.value forKey:@"abductThreshSlide"];
        //New addition
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionLowSlider.value forKey:@"elbowFlexLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRaiseSlider.value forKey:@"elbowFlexRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRangeSlider.value forKey:@"elbowFlexThreshSlide"];
        
            
      [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateLowSlider.value forKey:@"horizRotateLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRaiseSlider.value forKey:@"horizRotateRaiseSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRangeSlider.value forKey:@"horizRotateRangeSlide"];
            
    
    [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductLowSlider.value forKey:@"shouldAbductLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRaiseSlider.value forKey:@"shouldAbductRaiseSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRangeSlider.value forKey:@"shouldAbductRangeSlide"];
            
            
        //
        //Limits
        //self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
        
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
            
            self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
            self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
            self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
            
            
            self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
            self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
            self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];
        }
        else{
            
            //
            //Limits, Assign the slider value to the saved values
            // self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
            
            self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
            
            self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
            self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
            self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
            
            self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
            self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
            self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
            
            self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
            self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
            self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
            //New addition
            self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
            self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
            self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
            
            self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
            self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
            self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
            
            
            self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
            self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
            self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];

            
            
            //Limits
            
            //Next Limits, saves the current slider value to the phone
            [[NSUserDefaults standardUserDefaults] setFloat: self.verticalUpperSlider.value forKey:@"vertUpSlide2"];
            //[[NSUserDefaults standardUserDefaults] setFloat: self.verticalLowerSlider.value forKey:@"vertLowSlide"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.faceDownRollSlider.value forKey:@"faceDownSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.faceUpRollSlider.value forKey:@"faceUpSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.rollThresholdSlider.value forKey:@"rollThreshSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.flexionLoweredSlider.value forKey:@"flexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.flexionRaisedSlider.value forKey:@"flexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.flexionThresholdSlider.value forKey:@"flexThreshSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.abductionLoweredSlider.value forKey:@"abductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.abductionRaisedSlider.value forKey:@"abductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.abductionThresholdSlider.value forKey:@"abductThreshSlide2"];
            //New addition
            [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionLowSlider.value forKey:@"elbowFlexLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRaiseSlider.value forKey:@"elbowFlexRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRangeSlider.value forKey:@"elbowFlexThreshSlide2"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateLowSlider.value forKey:@"horizRotateLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRaiseSlider.value forKey:@"horizRotateRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRangeSlider.value forKey:@"horizRotateRangeSlide2"];
            
            
            [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductLowSlider.value forKey:@"shouldAbductLowSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRaiseSlider.value forKey:@"shouldAbductRaiseSlide2"];
            [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRangeSlider.value forKey:@"shouldAbductRangeSlide2"];
            //
            //Limits
            //self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
            self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
            
            self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
            self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
            self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
            
            self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
            self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
            self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
            
            self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
            self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
            self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
            
            //New addition
            self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
            self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
            self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
            
            
            self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
            self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
            self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
            
            
            self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
            self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
            self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];

            
        }
        
        [self updateData];
        [self reloadView];
        //Limits

        //archive the calibration info
        self.data = [NSKeyedArchiver archivedDataWithRootObject:self.calibration];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.data forKey:@"calibration1"];
        
        // [self.caliDefault setObject:self.calibration forKey:@"calibration1"];
        //self.verticalLowerSlider.value = 5;
        NSLog(@"The first one was launched");
    }
    else{
        
        /*if(_handSegmentedControl.selectedSegmentIndex==0){
            NSLog(@"Left Hand");
            _handSegmentedControl.selectedSegmentIndex = 1;
        }
        else NSLog(@"Right Hand");*/
        
        NSLog(@"The second one tried to launch");
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"calibration1"];
        self.calibration = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        // self.calibration = [self.caliDefault objectForKey:@"calibration1"];
        
        //[self keepRecent: self.calibration];
        //Returns the app to its saved state in calibration
  //  self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
        if([[NSUserDefaults standardUserDefaults] floatForKey:@"hand"]==0){
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
        
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
            
            self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
            self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
            self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
            
            
            self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
            self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
            self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];

        
        }
        else{
            
                self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
                
                self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
                self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
                self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
                
                self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
                self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
                self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
                
                self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
                self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
                self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
                
                //New addition
                self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
                self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
                self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
            
            self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
            self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
            self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
            
            
            self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
            self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
            self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];

                
        }
        //Hand choice
        _handSegmentedControl.selectedSegmentIndex =[[NSUserDefaults standardUserDefaults] floatForKey:@"hand"];

        NSLog(@"The second one was launched");
    }

    [self reloadData];
    [self reloadView];
}

#pragma mark - View

- (void)reloadView
{
    self.verticalUpperLabel.text = [NSString stringWithFormat:@"%.2f", self.verticalUpperSlider.value];
    //self.verticalLowerLabel.text = [NSString stringWithFormat:@"%.2f", self.verticalLowerSlider.value];
    
    self.faceDownRollLabel.text = [NSString stringWithFormat:@"%.2f", self.faceDownRollSlider.value];
    self.faceUpRollLabel.text = [NSString stringWithFormat:@"%.2f", self.faceUpRollSlider.value];
    self.rollThresholdLabel.text = [NSString stringWithFormat:@"%.2f", self.rollThresholdSlider.value];

    self.flexionLoweredLabel.text = [NSString stringWithFormat:@"%.2f", self.flexionLoweredSlider.value];
    self.flexionRaisedLabel.text = [NSString stringWithFormat:@"%.2f", self.flexionRaisedSlider.value];
    self.flexionThresholdLabel.text = [NSString stringWithFormat:@"%.2f", self.flexionThresholdSlider.value];

    self.abductionLoweredLabel.text = [NSString stringWithFormat:@"%.2f", self.abductionLoweredSlider.value];
    self.abductionRaisedLabel.text = [NSString stringWithFormat:@"%.2f", self.abductionRaisedSlider.value];
    self.abductionThresholdLabel.text = [NSString stringWithFormat:@"%.2f", self.abductionThresholdSlider.value];
    //New Addition
    self.elbowFlexionLowLabel.text =[NSString stringWithFormat:@"%.2f", self.elbowFlexionLowSlider.value];
    self.elbowFlexionRaiseLabel.text =[NSString stringWithFormat:@"%.2f", self.elbowFlexionRaiseSlider.value];
     self.elbowFlexionRangeLabel.text =[NSString stringWithFormat:@"%.2f", self.elbowFlexionRangeSlider.value];
    
    self.horizRotateLowLabel.text = [NSString stringWithFormat:@"%.2f", self.horizRotateLowSlider.value];
    self.horizRotateRaiseLabel.text = [NSString stringWithFormat:@"%.2f", self.horizRotateRaiseSlider.value];
    self.horizRotateRangeLabel.text = [NSString stringWithFormat:@"%.2f", self.horizRotateRangeSlider.value];
    
    
    self.shouldAbductLowLabel.text = [NSString stringWithFormat:@"%.2f", self.shouldAbductLowSlider.value];
    self.shouldAbductRaiseLabel.text = [NSString stringWithFormat:@"%.2f", self.shouldAbductRaiseSlider.value];
    self.shouldAbductRangeLabel.text = [NSString stringWithFormat:@"%.2f", self.shouldAbductRangeSlider.value];
    
    
    
    
   

}

#pragma mark - Actions

- (IBAction)saveButtonPressed:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
        //Hand choice
    [[NSUserDefaults standardUserDefaults] setFloat: _handSegmentedControl.selectedSegmentIndex forKey:@"hand"];
    //Hand update
    _handSegmentedControl.selectedSegmentIndex= [[NSUserDefaults standardUserDefaults] floatForKey:@"hand"];
    if([[NSUserDefaults standardUserDefaults] floatForKey:@"hand"]==0){//for left hand

    //Once the save button is pressed, the slider values are saved to defaults
    [[NSUserDefaults standardUserDefaults] setFloat: self.verticalUpperSlider.value forKey:@"vertUpSlide"];
    //[[NSUserDefaults standardUserDefaults] setFloat: self.verticalLowerSlider.value forKey:@"vertLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.faceDownRollSlider.value forKey:@"faceDownSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.faceUpRollSlider.value forKey:@"faceUpSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.rollThresholdSlider.value forKey:@"rollThreshSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.flexionLoweredSlider.value forKey:@"flexLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.flexionRaisedSlider.value forKey:@"flexRaiseSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.flexionThresholdSlider.value forKey:@"flexThreshSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.abductionLoweredSlider.value forKey:@"abductLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.abductionRaisedSlider.value forKey:@"abductRaiseSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.abductionThresholdSlider.value forKey:@"abductThreshSlide"];
    //New addition
    [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionLowSlider.value forKey:@"elbowFlexLowSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRaiseSlider.value forKey:@"elbowFlexRaiseSlide"];
    [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRangeSlider.value forKey:@"elbowFlexThreshSlide"];
    
        
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateLowSlider.value forKey:@"horizRotateLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRaiseSlider.value forKey:@"horizRotateRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRangeSlider.value forKey:@"horizRotateRangeSlide"];
        
        
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductLowSlider.value forKey:@"shouldAbductLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRaiseSlider.value forKey:@"shouldAbductRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRangeSlider.value forKey:@"shouldAbductRangeSlide"];
        

  
    
    //The slider values are assigned the value of the defaults, Immediately displays the changes
    //self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
    self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
    
    self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
    self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
    self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
    
    self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
    self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
    self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
    
    self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
    self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
    self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
    //New addition
    self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
    self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
    self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
        
        
        self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
        self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
        self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
        
        
        self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
        self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
        self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];

    }
    else{//for right hand
        
        
        //Once the save button is pressed, the slider values are saved to defaults
        [[NSUserDefaults standardUserDefaults] setFloat: self.verticalUpperSlider.value forKey:@"vertUpSlide2"];
        //[[NSUserDefaults standardUserDefaults] setFloat: self.verticalLowerSlider.value forKey:@"vertLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceDownRollSlider.value forKey:@"faceDownSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceUpRollSlider.value forKey:@"faceUpSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.rollThresholdSlider.value forKey:@"rollThreshSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionLoweredSlider.value forKey:@"flexLowSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionRaisedSlider.value forKey:@"flexRaiseSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionThresholdSlider.value forKey:@"flexThreshSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionLoweredSlider.value forKey:@"abductLowSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionRaisedSlider.value forKey:@"abductRaiseSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionThresholdSlider.value forKey:@"abductThreshSlide2"];
        //New addition
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionLowSlider.value forKey:@"elbowFlexLowSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRaiseSlider.value forKey:@"elbowFlexRaiseSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.elbowFlexionRangeSlider.value forKey:@"elbowFlexThreshSlide2"];
        
        
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateLowSlider.value forKey:@"horizRotateLowSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRaiseSlider.value forKey:@"horizRotateRaiseSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.horizRotateRangeSlider.value forKey:@"horizRotateRangeSlide2"];
        
        
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductLowSlider.value forKey:@"shouldAbductLowSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRaiseSlider.value forKey:@"shouldAbductRaiseSlide2"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.shouldAbductRangeSlider.value forKey:@"shouldAbductRangeSlide2"];
        

        
        
        //The slider values are assigned the value of the defaults, Immediately displays the changes
        //self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
        
        self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
        self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
        self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
        
        
        self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
        self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
        self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];
    }
    
    [self updateData];
    
    [[TUHTTPSessionManager sessionManager] saveCalibration:self.calibration completion:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"The server if ran!");
        } else if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];


    
    NSLog(@"Save Button Ran");
}

- (IBAction)segmentedControlSelected:(id)sender
{
    [self reloadData];
}

- (IBAction)sliderValueChanged:(id)sender
{
    [self updateData];
    [self reloadView];
    NSLog(@"Slide value changed");
}

#pragma mark - Data

- (void)reloadData
{
    if (self.handSegmentedControl.selectedSegmentIndex == 0) {
        if (!self.patient.leftHandCalibration) {
            //self.calibration = [[TUPatientCalibration alloc] init];
            self.patient.leftHandCalibration = self.calibration;
            
            [self updateData];
        }
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide"];
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide"];
    

        self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide"];
        self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide"];
        self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide"];
        
        
        self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide"];
        self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide"];
        self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide"];
        
        //self.calibration = self.patient.leftHandCalibration;
        self.calibration.patientId = self.patient.patientId;
        //[[NSUserDefaults standardUserDefaults] setObject: self.patient.patientId forKey:@"pId"];
        self.calibration.hand = 1;
    } else if (self.handSegmentedControl.selectedSegmentIndex == 1) {
        if (!self.patient.rightHandCalibration) {
           // self.calibration = [[TUPatientCalibration alloc] init];
            self.patient.rightHandCalibration = self.calibration;
            [self updateData];
        }
        self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide2"];
        self.verticalUpperSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertUpSlide2"];
        
        self.faceDownRollSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"faceDownSlide2"];
        self.faceUpRollSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:@"faceUpSlide2"];
        self.rollThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rollThreshSlide2"];
        
        self.flexionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexLowSlide2"];
        self.flexionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexRaiseSlide2"];
        self.flexionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"flexThreshSlide2"];
        
        self.abductionLoweredSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductLowSlide2"];
        self.abductionRaisedSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductRaiseSlide2"];
        self.abductionThresholdSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"abductThreshSlide2"];
        //New addition
        self.elbowFlexionLowSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexLowSlide2"];
        self.elbowFlexionRaiseSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexRaiseSlide2"];
        self.elbowFlexionRangeSlider.value =[[NSUserDefaults standardUserDefaults] floatForKey:@"elbowFlexThreshSlide2"];
        
        self.horizRotateLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateLowSlide2"];
        self.horizRotateRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRaiseSlide2"];
        self.horizRotateRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"horizRotateRangeSlide2"];
        
        
        self.shouldAbductLowSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductLowSlide2"];
        self.shouldAbductRaiseSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRaiseSlide2"];
        self.shouldAbductRangeSlider.value=[[NSUserDefaults standardUserDefaults] floatForKey:@"shouldAbductRangeSlide2"];
        //self.calibration = self.patient.rightHandCalibration;
        self.calibration.patientId = self.patient.patientId;
        self.calibration.hand = 2;
        //[[NSUserDefaults standardUserDefaults] setObject: self.patient.patientId forKey:@"pId"];
    }
    
    [self reloadView];
    
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//    
//    NSUInteger hand = self.handSegmentedControl.selectedSegmentIndex + 1;
//    
//    TUPatient *patient = [TUHTTPSessionManager sessionManager].currentUser;
//    [[TUHTTPSessionManager sessionManager] getPatientCalibration:patient hand:hand completion:^(TUPatientCalibration *calibration, NSError *error) {
//        if (calibration) {
//            [SVProgressHUD dismiss];
//            self.calibration = calibration;
//            [self reloadView];
//        } else if (error) {
//            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"An unknown error occurred."];
//        }
//    }];
}

- (void)updateData
{
    //I save all of the slider values to an integer to remove the float and then i just assign then to the slider and calibration variable
    //Saves the slider value to calibration data
    
    int x = self.verticalUpperSlider.value;
    self.verticalUpperSlider.value =x; //I save the discrete value to the slider
    self.calibration.verticalUpperThreshhold =  x*.04;//Then, i multiply that value to .05 and save that to the actual calibration variable
    
     /*   x = self.verticalLowerSlider.value;
    self.verticalLowerSlider.value = x;*/
    self.calibration.verticalLowerThreshhold = x *-.04;
    //End of Calibration for Vertical Speed
    
    //Start of Calibration for Roll
    //facedown = proangle
    x = self.faceDownRollSlider.value;
    self.faceDownRollSlider.value = x;
    self.calibration.faceDownRollValue = 90+x;
    
    x = self.faceUpRollSlider.value;
    self.faceUpRollSlider.value = x;
    self.calibration.faceUpRollValue = 90-x ;
    
    x = self.rollThresholdSlider.value;
    self.rollThresholdSlider.value = x;
    self.calibration.rollThreshold = x;
    
    //Start of Calibration for Flexion
    x =self.flexionLoweredSlider.value;
    self.flexionLoweredSlider.value = x;
    self.calibration.flexionLoweredValue = x;
    
    x =self.flexionRaisedSlider.value;
    self.flexionRaisedSlider.value = x;
    self.calibration.flexionRaisedValue = x;
    
    x =self.flexionThresholdSlider.value;
    self.flexionThresholdSlider.value = x;
    self.calibration.flexionThreshold = x;
    
    //Start of Calibration for Abduction which is Rotation Now
    x = self.abductionLoweredSlider.value;
    self.abductionLoweredSlider.value = x;
    self.calibration.abductionLoweredValue =90-x;
    
    x = self.abductionRaisedSlider.value;
    self.abductionRaisedSlider.value = x;
    self.calibration.abductionRaisedValue = 90+x;
    
    x = self.abductionThresholdSlider.value;
    self.abductionThresholdSlider.value = x;
    self.calibration.abductionThreshold = x;
    
    //new addition
    x = self.elbowFlexionLowSlider.value;
    self.elbowFlexionLowSlider.value = x;
    self.calibration.elbowFlexionLoweredValue = x;
    
    x = self.elbowFlexionRaiseSlider.value;
    self.elbowFlexionRaiseSlider.value = x;
    self.calibration.elbowFlexionRaisedValue = x;
    
    x = self.elbowFlexionRangeSlider.value;
    self.elbowFlexionRangeSlider.value = x;
    self.calibration.elbowFlexionThreshold = x;
    
    
    
    x = self.horizRotateLowSlider.value;
    self.horizRotateLowSlider.value = x;
    self.calibration.horizRotateLowValue = x;
    
    x = self.horizRotateRaiseSlider.value;
    self.horizRotateRaiseSlider.value = x;
    self.calibration.horizRotateRaiseValue = x;
    
    x = self.horizRotateRangeSlider.value;
    self.horizRotateRangeSlider.value = x;
    self.calibration.horizRotateRangeValue = x;
    
    x = self.shouldAbductLowSlider.value;
    self.shouldAbductLowSlider.value = x;
    self.calibration.shouldAbductLowValue = x;
    
    x = self.shouldAbductRaiseSlider.value;
    self.shouldAbductRaiseSlider.value = x;
    self.calibration.shouldAbductRaiseValue = x;
    
    x = self.shouldAbductRangeSlider.value;
    self.shouldAbductRangeSlider.value = x;
    self.calibration.shouldAbductRangeValue = x;
    
 
    //self.calibration.hand = _handSegmentedControl.selectedSegmentIndex;
    
    //self.calibration.flexionLoweredValue = self.flexionLoweredSlider.value;

    /*self.calibration.verticalUpperThreshhold = self.verticalUpperSlider.value;
    self.calibration.verticalLowerThreshhold = self.verticalLowerSlider.value;
    
    self.calibration.faceDownRollValue = self.faceDownRollSlider.value;
    self.calibration.faceUpRollValue = self.faceUpRollSlider.value;
    self.calibration.rollThreshold = self.rollThresholdSlider.value;
    
    self.calibration.flexionLoweredValue = self.flexionLoweredSlider.value;
    self.calibration.flexionRaisedValue = self.flexionRaisedSlider.value;
    self.calibration.flexionThreshold = self.flexionThresholdSlider.value;
    
    self.calibration.abductionLoweredValue = self.abductionLoweredSlider.value;
    self.calibration.abductionRaisedValue = self.abductionRaisedSlider.value;
    self.calibration.abductionThreshold = self.abductionThresholdSlider.value;*/
}


@end

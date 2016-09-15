//
//  TUPatientCalibration.m
//  PTMotion
//
//  Created by David Messing on 1/1/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

#import "TUPatientCalibration.h"

// Default thresholds
static float const kDefaultVerticalUpperThreshold = 0.2f;
static float const kDefaultVerticalLowerThreshold = -0.2f;

static float const kDefaultFaceDownRollValue      = 180.0f;
static float const kDefaultFaceUpRollValue        = 00.0f;
static float const kDefaultRollThreshold          = 10.0f;

static float const kDefaultFlexionLoweredValue    = 0.0f;
static float const kDefaultFlexionRaisedValue     = 90.0f;
static float const kDefaultFlexionThreshold       = 10.0f;

static float const kDefaultAbductionLoweredValue  = 0.0f;
static float const kDefaultAbductionRaisedValue   = 90.0f;
static float const kDefaultAbductionThreshold     = 10.0f;

@implementation TUPatientCalibration

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        if (![dict objectForKey:@"verticalUpperThreshhold"]) { self.verticalUpperThreshhold = kDefaultVerticalUpperThreshold; }
        if (![dict objectForKey:@"verticalLowerThreshhold"]) { self.verticalLowerThreshhold = kDefaultVerticalLowerThreshold; }
        
        if (![dict objectForKey:@"faceDownRollValue"]) { self.faceDownRollValue = kDefaultFaceDownRollValue; }
        if (![dict objectForKey:@"faceUpRollValue"]) { self.faceUpRollValue = kDefaultFaceUpRollValue; }
        if (![dict objectForKey:@"rollThreshold"]) { self.rollThreshold = kDefaultRollThreshold; }
        
        if (![dict objectForKey:@"flexionLoweredValue"]) { self.flexionLoweredValue = kDefaultFlexionLoweredValue; }
        if (![dict objectForKey:@"flexionRaisedValue"]) { self.flexionRaisedValue = kDefaultFlexionRaisedValue; }
        if (![dict objectForKey:@"flexionThreshold"]) { self.flexionThreshold = kDefaultFlexionThreshold; }
        
        if (![dict objectForKey:@"abductionLoweredValue"]) { self.abductionLoweredValue = kDefaultAbductionLoweredValue; }
        if (![dict objectForKey:@"abductionRaisedValue"]) { self.abductionRaisedValue = kDefaultAbductionRaisedValue; }
        if (![dict objectForKey:@"abductionThreshold"]) { self.abductionThreshold = kDefaultAbductionThreshold; }
        
        if (![dict objectForKey:@"elbowFlexionLoweredValue"]) { self.elbowFlexionLoweredValue = kDefaultFlexionLoweredValue; }
        if (![dict objectForKey:@"elbowFlexionRaisedValue"]) { self.elbowFlexionRaisedValue = kDefaultFlexionRaisedValue; }
        if (![dict objectForKey:@"elbowFlexionThreshold"]) { self.elbowFlexionThreshold = kDefaultFlexionThreshold; }
        
        if (![dict objectForKey:@"horizRotateLowValue"]) { self.horizRotateLowValue = kDefaultFlexionLoweredValue; }
        if (![dict objectForKey:@"horizRotateRaiseValue"]) { self.horizRotateRaiseValue = kDefaultFlexionRaisedValue; }
        if (![dict objectForKey:@"horizRotateRangeValue"]) { self.horizRotateRangeValue = kDefaultFlexionThreshold; }
        
        if (![dict objectForKey:@"shouldAbductLowValue"]) { self.shouldAbductLowValue = kDefaultFlexionLoweredValue; }
        if (![dict objectForKey:@"shouldAbductRaiseValue"]) { self.shouldAbductRaiseValue = kDefaultFlexionRaisedValue; }
        if (![dict objectForKey:@"shouldAbductRangeValue"]) { self.shouldAbductRangeValue = kDefaultFlexionThreshold; }
    }
    //
    
   /* if([CalibrationViewController isFirstTime]){
        self.calibration = [[TUPatientCalibration alloc]init];
        
        //self.caliDefault = [NSUserDefaults standardUserDefaults];
        NSLog(@"The first caliDefault tries to launch");
        //Setting Defaults
        
        
        
        //
        //Limits, Assign the slider value to the saved values
        self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
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
        
        //Limits
        
        //Next Limits, saves the current slider value to the phone
        [[NSUserDefaults standardUserDefaults] setFloat: self.verticalUpperSlider.value forKey:@"vertUpSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.verticalLowerSlider.value forKey:@"vertLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceDownRollSlider.value forKey:@"faceDownSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.faceUpRollSlider.value forKey:@"faceUpSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.rollThresholdSlider.value forKey:@"rollThreshSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionLoweredSlider.value forKey:@"flexLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionRaisedSlider.value forKey:@"flexRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.flexionThresholdSlider.value forKey:@"flexThreshSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionLoweredSlider.value forKey:@"abductLowSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionRaisedSlider.value forKey:@"abductRaiseSlide"];
        [[NSUserDefaults standardUserDefaults] setFloat: self.abductionThresholdSlider.value forKey:@"abductThreshSlide"];
        
        //
        //Limits
        self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
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
        NSLog(@"The second one tried to launch");
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"calibration1"];
        self.calibration = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        // self.calibration = [self.caliDefault objectForKey:@"calibration1"];
        
        //[self keepRecent: self.calibration];
        //Returns the app to its saved state in calibration
        self.verticalLowerSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"vertLowSlide"];
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
    }
    */
    
    //
    return self;
}

@end

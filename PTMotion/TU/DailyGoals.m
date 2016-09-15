//
//  DailyGoals.m
//  ARMStrokes
//
//  Created by Ted Smith on 5/26/15.
//  Copyright (c) 2015 David Messing. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import "DailyGoals.h"

// Default thresholds
static integer_t const fRTLengthConst = 30;
static integer_t const fRTNumConst = 1;

static integer_t const eFTLengthConst     = 30;
static integer_t const eFTNumConst        = 1;

static integer_t const eRFTLengthConst    = 30;
static integer_t const eRFTNumConst   = 1;

static integer_t const eRSTLengthConst    = 30;
static integer_t const eRSTNumConst      = 1;

static integer_t const sFTLengthConst = 30;
static integer_t const sFTNumConst  = 1;

static integer_t const sRTLengthConst    = 30;
static integer_t const sRTNumConst   = 1;

@implementation DailyGoals

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        if (![dict objectForKey:@"fRTLength"]) { self.fRTLength = fRTLengthConst; }
        if (![dict objectForKey:@"fRTNum"]) { self.fRTNum = fRTNumConst; }
        
        if (![dict objectForKey:@"eFTLength"]) { self.eFTLength = eFTLengthConst ; }
        if (![dict objectForKey:@"eFTNum"]) { self.eFTNum = eFTNumConst ; }
        
        if (![dict objectForKey:@"eRFTLength"]) { self.eRFTLength = eRFTLengthConst ; }
        if (![dict objectForKey:@"eRFTNum"]) { self.eRFTNum = eRFTNumConst; }
        
        if (![dict objectForKey:@"eRSTLength"]) { self.eRSTLength = eRSTLengthConst; }
        if (![dict objectForKey:@"eRSTNum"]) { self.eRSTNum = eRSTNumConst; }
        
        if (![dict objectForKey:@"sFTLength"]) { self.sFTLength = sFTLengthConst; }
        if (![dict objectForKey:@"sFTNum"]) { self.sFTNum = sFTNumConst; }
        if (![dict objectForKey:@"sRTLength "]) { self.sRTLength = sRTLengthConst; }
        if (![dict objectForKey:@"sRTNum"]) { self.sRTNum = sRTNumConst; }
        
        if (![dict objectForKey:@"hRTLength "]) { self.hRTLength = sRTLengthConst; }
        if (![dict objectForKey:@"hRTNum"]) { self.hRTNum = sRTNumConst; }
        if (![dict objectForKey:@"sATLength"]) { self.sATLength = sFTLengthConst; }
        if (![dict objectForKey:@"sATNum"]) { self.sATNum = sFTNumConst; }
        if (![dict objectForKey:@"patientId"]) { self.patientId = @"id"; }

     
    }

    
    return self;
}

@end
//
//  AppLogin.h
//  PTMotion
//
//  Created by David Messing on 12/26/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "JSONModel.h"

@class TUPatient;

@interface TUAppLogin : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) TUPatient *patient;

@end

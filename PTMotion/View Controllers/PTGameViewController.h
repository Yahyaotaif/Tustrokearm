//
//  PTGameViewController.h
//  PTMotion
//
//  Created by David Messing on 11/10/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTViewController.h"

@class FigureView;

typedef NS_ENUM(NSUInteger, PTGameType) {
    PTGameTypeMonkey,
    PTGameTypeAstronaut
};

@interface PTGameViewController : PTViewController

@property (nonatomic) PTGameType gameType;

@property (nonatomic, weak) IBOutlet FigureView *figureView;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundView;

- (void)configureView;
- (void)presentSessionResults;

@end

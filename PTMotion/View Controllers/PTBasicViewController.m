//
//  PTBasicViewController.m
//  PTMotion
//
//  Created by David Messing on 10/27/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTBasicViewController.h"

// view controllers
#import "PTSessionResultsViewController.h"

// segues
NSString * const SessionResultsSegue = @"SessionResultsSegue";

@interface PTBasicViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *timerLabel;

@end

@implementation PTBasicViewController

#pragma mark - View

- (void)updateTimerLabel:(NSString *)text
{
    self.timerLabel.text = text;
}

- (void)updateScoreLabel:(NSString *)text
{
    self.scoreLabel.text = text;
}

#pragma mark - Navigation

- (void)presentSessionResults
{
    [self performSegueWithIdentifier:SessionResultsSegue sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:SessionResultsSegue]) {
        UINavigationController *navController = [segue destinationViewController];
        PTSessionResultsViewController *viewController = [[navController viewControllers] firstObject];
        viewController.session = self.session;
    }
}

@end

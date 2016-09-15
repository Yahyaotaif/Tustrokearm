//
//  PTGameViewController.m
//  PTMotion
//
//  Created by David Messing on 11/10/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTGameViewController.h"

// view controllers
#import "PTSessionResultsViewController.h"

// segues
NSString * const SessionGameResultsSegue = @"SessionGameResultsSegue";

@implementation PTGameViewController

#pragma mark - View controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

#pragma mark - View

- (void)configureView
{
    // Implement in subclasses
}

#pragma mark - Navigation

- (void)presentSessionResults
{
    [self performSegueWithIdentifier:SessionGameResultsSegue sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:SessionGameResultsSegue]) {
        UINavigationController *navController = [segue destinationViewController];
        PTSessionResultsViewController *viewController = [[navController viewControllers] firstObject];
        viewController.session = self.session;
    }
}

@end

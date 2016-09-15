//
//  SessionResultsViewController.m
//  MotionTraking
//
//  Created by David Messing on 3/16/14.
//  Copyright (c) 2014 David Messing. All rights reserved.
//

#import "PTSessionResultsViewController.h"

// views
#import "BEMSimpleLineGraphView.h"

// PT
#import "PTSession.h"

// TU
#import "TUHTTPSessionManager.h"
#import "TUSession.h"
#import "TUSession+PTSession.h"

// misc
#import "SVProgressHUD.h"

//audio
@import AudioToolbox;
@interface PTSessionResultsViewController () <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell *totalTimeCell;
@property (nonatomic, weak) IBOutlet UITableViewCell *completedTimeCell;
@property (nonatomic, weak) IBOutlet UITableViewCell *actionsCountCell;

@property (nonatomic, weak) IBOutlet BEMSimpleLineGraphView *graphView;

@end

@implementation PTSessionResultsViewController

#pragma mark - View controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.graphView.enableBezierCurve = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.totalTimeCell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fs", self.session.sessionTime];
    self.completedTimeCell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fs", self.session.sessionTime - self.session.sessionTimeRemaining];
    self.actionsCountCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.session.actionCount];
    
    [self.graphView reloadGraph];
    
    NSLog(@"The graph just displayed.");
    
    
    
    
    //Typewriter Alert to signal the end!
    AudioServicesPlaySystemSound(1035);
    NSLog(@"Done!!");
}

#pragma mark - Actions

- (IBAction)doneButtonPressed:(id)sender
{
    [SVProgressHUD show];
    
    TUSession *session = [TUSession TUSessionWithPTSession:self.session];
    [[TUHTTPSessionManager sessionManager] saveSessionResults:session completion:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD dismiss];
            
            UIViewController *presenter = self.navigationController.presentingViewController;
            [self dismissViewControllerAnimated:YES completion:^{
                // pop back to main menu
                UINavigationController *navController;
                if ([presenter isKindOfClass:[UINavigationController class]]) {
                    navController = (UINavigationController *)presenter;
                } else {
                    navController = presenter.navigationController;
                }
                [navController popToRootViewControllerAnimated:YES];
            }];
        } else if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

#pragma mark - BEMSimpleLineGraphDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    NSArray *dataPoints = [self.session dataPoints];
    return [dataPoints count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    NSArray *dataPoints = [self.session dataPoints];
    NSNumber *dataPoint = dataPoints[index];
    
    return [dataPoint doubleValue];
}

@end

//
//  BBMainViewController.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "BBMainViewController.h"
#import "BBUtility.h"
#import "BBHttpClient.h"
#import "SSPullToRefreshView.h"
#import "BBAlarmViewCell.h"
#import "UIViewController+AddAlarm.h"
#import "TWMessageBarManager.h"

#define CELL_IDENTIFIER @"defaultCell"

@interface BBMainViewController () <SSPullToRefreshViewDelegate, SWTableViewCellDelegate>
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) SSPullToRefreshView *pullToRefreshView;
@property (nonatomic, strong) NSArray *alarms;
@end

@implementation BBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Bellbird";
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonClicked:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView registerClass:[BBAlarmViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    
    [self refresh];
}

# pragma mark - Refresh View
- (void)viewDidLayoutSubviews {
    if(self.pullToRefreshView == nil) {
        self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.pullToRefreshView = nil;
}

- (void)refresh {
    [self.pullToRefreshView startLoading];
    
    [[[BBHttpClient sharedClient] fetchAlarms] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull t) {
        
        NSArray *fetchedAlarms = t.result;
        NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                            sortDescriptorWithKey:@"createdAt"
                                            ascending:NO];
        self.alarms = [fetchedAlarms sortedArrayUsingDescriptors:@[dateDescriptor]];
        
        [self.tableView reloadData];
        [self.pullToRefreshView finishLoading];
        return nil;
    }];
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alarms.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBAlarmViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.alarms[indexPath.row];
    return cell;
}

#pragma mark - Button Delegates
- (void)swipeableTableViewCell:(BBAlarmViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSInteger voteChange = index == 0 ? -1 : 1;
    NSInteger newVoteCount = cell.model.votes + voteChange;
    [[[BBHttpClient sharedClient] updateAlarm:cell.model withVotes:newVoteCount] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull t) {
        if (t.error) {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"Vote Update Failed",nil)
                                                           description:@"Please try to up/down vote again later."
                                                                  type:TWMessageBarMessageTypeError];
        }
        else {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"Vote Update Successful",nil)
                                                           description:[NSString stringWithFormat:@"The new vote count is %ld", newVoteCount]
                                                                  type:TWMessageBarMessageTypeInfo];
            [self refresh];
        }
        
        return nil;
    }];
}

- (void)addButtonClicked:(UIButton *)button
{
    [self presentAddAlarmViewWithCompletedBlock:^(BOOL isCompleted) {
        if (isCompleted) {
            [self refresh];
        }
    }];
}


@end

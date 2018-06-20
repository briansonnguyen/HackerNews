//
//  StoryListTableViewController.m
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "StoryListTableViewController.h"
#import "StoryViewController.h"
#import "StoryViewModel.h"

@interface StoryListTableViewController ()

@end

@implementation StoryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Bindings

- (void)bindViewModel {
    self.title = self.viewModel.title;
    @weakify(self);
    [[self.viewModel.hasUpdatedContent deliverOnMainThread]
     subscribeNext:^(id _) {
         @strongify(self);
         [self.tableView reloadData];
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfStory;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [self.viewModel titleOfStoryAtRow:indexPath.row];
    cell.textLabel.textColor = [self.viewModel textColorOfStoryAtRow:indexPath.row];
    
    cell.detailTextLabel.text = [self.viewModel infoOfStoryAtRow:indexPath.row];
    cell.detailTextLabel.textColor = [self.viewModel textColorOfStoryAtRow:indexPath.row];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    StoryViewController *viewController = segue.destinationViewController;
    viewController.viewModel = [self.viewModel storyViewModelForRow:indexPath.row];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end

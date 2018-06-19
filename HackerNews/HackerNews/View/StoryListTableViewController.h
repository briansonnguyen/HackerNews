//
//  StoryListTableViewController.h
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryListViewModel.h"

@interface StoryListTableViewController : UITableViewController

@property (strong, nonatomic) StoryListViewModel *viewModel;

@end

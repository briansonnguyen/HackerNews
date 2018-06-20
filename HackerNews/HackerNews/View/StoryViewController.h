//
//  StoryViewController.h
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryViewModel.h"

@interface StoryViewController : UIViewController

@property (strong, nonatomic) StoryViewModel *viewModel;

@end

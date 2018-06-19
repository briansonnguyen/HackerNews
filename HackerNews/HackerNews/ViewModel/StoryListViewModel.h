//
//  StoryListViewModel.h
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NewsServiceImpl.h"

@interface StoryListViewModel : NSObject

@property (nonatomic, readonly) RACSignal *hasUpdatedContent;

- (instancetype)initWithModel:(NewsServiceImpl *)newsService;
- (NSString *)title;
- (NSInteger)numberOfStory;
- (NSString *)titleOfStoryAtRow:(NSInteger)row;
- (NSString *)infoOfStoryAtRow:(NSInteger)row;
- (UIColor *)textColorOfStoryAtRow:(NSInteger)row;

@end

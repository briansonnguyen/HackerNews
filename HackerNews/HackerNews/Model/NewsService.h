//
//  NewsService.h
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol NewsService <NSObject>

- (RACSignal *)topStoryIds;
- (RACSignal *)storyWithId:(NSInteger)storyId;
- (RACSignal *)topStoriesSync;

@end

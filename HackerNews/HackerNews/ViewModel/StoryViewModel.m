//
//  StoryViewModel.m
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "StoryViewModel.h"
#import "DataStoreImpl.h"

@interface StoryViewModel()

@property (strong, nonatomic) Story *story;
@property (strong, nonatomic) DataStoreImpl *dataStore;

@end

@implementation StoryViewModel

- (instancetype)initWithStory:(Story *)story {
    if (self = [super init]) {
        _story = story;
        _dataStore = [DataStoreImpl sharedManager];
    }
    return self;
}

- (NSString *)title {
    return self.story.title;
}

- (NSURL *)url {
    return self.story.url;
}

@end

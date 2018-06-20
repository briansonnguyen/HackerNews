//
//  StoryListViewModel.m
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "StoryListViewModel.h"
#import "Story.h"
#import "Utils.h"

@interface StoryListViewModel()

@property (strong, nonatomic) NewsServiceImpl *newsService;
@property (strong, nonatomic) NSMutableArray *stories;
@property (strong, nonatomic) DataStoreImpl *dataStore;

@end


@implementation StoryListViewModel

- (instancetype)initWithModel:(NewsServiceImpl *)newsService dataStore:(DataStoreImpl *)dateStore {
    if (self = [super init]) {
        _newsService = newsService;
        _dataStore = dateStore;
        _stories = [[NSMutableArray alloc] init];
        
        RAC(self, stories) = [[newsService topStoriesSync] startWith:@[]];
        _hasUpdatedContent = [RACObserve(self, stories) mapReplace:@(YES)];
    }
    return self;
}

#pragma mark -

- (NSString *)title {
    return @"Top Stories";
}

- (NSInteger)numberOfStory {
    return self.stories.count;
}

- (NSString *)titleOfStoryAtRow:(NSInteger)row {
    Story *aStory = self.stories[row];
    return aStory.title;
}

- (NSString *)infoOfStoryAtRow:(NSInteger)row {
    Story *aStory = self.stories[row];
    return [NSString stringWithFormat:@"%@ - %ld points by %@",
            [Utils timeAgoFromTimestamp:aStory.time],
            aStory.score,
            aStory.by];
}

- (UIColor *)textColorOfStoryAtRow:(NSInteger)row {
    Story *aStory = self.stories[row];
    if (aStory.read  || [self.dataStore getReadStateForStory:aStory.identifier])
        return [UIColor lightGrayColor];
    return [UIColor darkTextColor];
}

- (StoryViewModel *)storyViewModelForRow:(NSInteger)row {
    Story *aStory = self.stories[row];
    aStory.read = YES;
    [self.dataStore saveStoryWithId:aStory.identifier];
    StoryViewModel *viewModel = [[StoryViewModel alloc] initWithStory:aStory];
    return viewModel;
}

@end

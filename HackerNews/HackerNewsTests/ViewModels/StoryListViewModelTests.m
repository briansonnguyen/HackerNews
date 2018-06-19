//
//  StoryListViewModelTests.m
//  HackerNewsTests
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StoryListViewModel.h"
#import "Story.h"

@interface MockNewsServiceImpl : NewsServiceImpl

@property (nonatomic, assign) BOOL didLoadStories;

@end

@implementation MockNewsServiceImpl

- (RACSignal *)topStoriesSync {
    self.didLoadStories = YES;
    
    NSArray *stories = @[
                         [[Story alloc] initWithId:1
                                                By:@"User1"
                                             score:99
                                              time:[NSNumber numberWithInteger:1428990352]
                                             title:@"Story1"
                                               url:[NSURL URLWithString:@"https://www.mercurynews.com/2018/06/14/bay-area-businessman-must-pay-136000-in-tech-support-scam-against-elderly/"]],
                         [[Story alloc] initWithId:222
                                                By:@"User2"
                                             score:79
                                              time:[NSNumber numberWithInteger:1428990352]
                                             title:@"Story2"
                                               url:[NSURL URLWithString:@"https://www.usatoday.com/story/money/economy/2018/06/13/50-worst-cities-to-live-in/35909271/"]]
                         ];
    return [RACSignal return:stories];
}

@end

#pragma mark -

@interface StoryListViewModelTests : XCTestCase

@property (nonatomic, strong) MockNewsServiceImpl *mockNewsService;

@end


@implementation StoryListViewModelTests

- (void)setUp {
    [super setUp];
    self.mockNewsService = [[MockNewsServiceImpl alloc] init];
}

- (void)tearDown {
    self.mockNewsService = nil;
    [super tearDown];
}

- (void)testViewModelLoadTopStoriesAfterInit {
    id _ __unused = [[StoryListViewModel alloc] initWithModel:self.mockNewsService];
    XCTAssertTrue(self.mockNewsService.didLoadStories);
}

- (void)testViewModelReturnsStoriesCount {
    StoryListViewModel *viewModel = [[StoryListViewModel alloc] initWithModel:self.mockNewsService];
    XCTAssertEqual([viewModel numberOfStory], 2);
}

- (void)testViewModelStoryTitles {
    StoryListViewModel *viewModel = [[StoryListViewModel alloc] initWithModel:self.mockNewsService];
    XCTAssertEqual([viewModel titleOfStoryAtRow:0], @"Story1");
    XCTAssertEqual([viewModel titleOfStoryAtRow:1], @"Story2");
}

- (void)testViewModelStoryInfo {
    StoryListViewModel *viewModel = [[StoryListViewModel alloc] initWithModel:self.mockNewsService];
    XCTAssertTrue([[viewModel infoOfStoryAtRow:0] isEqualToString:@"3 years ago - 99 points by User1"]);
    XCTAssertTrue([[viewModel infoOfStoryAtRow:1] isEqualToString:@"3 years ago - 79 points by User2"]);
}

@end

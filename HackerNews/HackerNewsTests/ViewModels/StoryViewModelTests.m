//
//  StoryViewModel.m
//  HackerNewsTests
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StoryViewModel.h"
#import "Story.h"

@interface StoryViewModelTests : XCTestCase

@property (strong, nonatomic) Story *story;

@end

@implementation StoryViewModelTests

- (void)setUp {
    [super setUp];
    self.story = [[Story alloc] initWithId:1
                                          By:@"User1"
                                       score:99
                                        time:[NSNumber numberWithInteger:1428990352]
                                       title:@"Story1"
                                         url:[NSURL URLWithString:@"https://www.mercurynews.com/2018/06/14/bay-area-businessman-must-pay-136000-in-tech-support-scam-against-elderly/"]];
}

- (void)tearDown {
    self.story = nil;
    [super tearDown];
}

- (void)testStoryTitle {
    StoryViewModel *viewModel = [[StoryViewModel alloc] initWithStory:self.story];
    XCTAssertEqual([viewModel title], @"Story1");
}

- (void)testStoryUrl {
    StoryViewModel *viewModel = [[StoryViewModel alloc] initWithStory:self.story];
    XCTAssertEqual([[viewModel url] absoluteString], @"https://www.mercurynews.com/2018/06/14/bay-area-businessman-must-pay-136000-in-tech-support-scam-against-elderly/");
}

@end

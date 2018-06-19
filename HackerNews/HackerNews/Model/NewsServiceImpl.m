//
//  NewsServiceImpl.m
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "NewsServiceImpl.h"
#import "Story.h"
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import <AFNetworking2-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import "AFHTTPRequestOperationManager+Synchronous.h"

@implementation NewsServiceImpl

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (id)sharedManager {
    static NewsServiceImpl *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * apiURL = [[NSURL URLWithString:@"https://hacker-news.firebaseio.com"] URLByAppendingPathComponent:@"v0"];
        sharedManager = [[NewsServiceImpl alloc] initWithBaseURL:apiURL];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        sharedManager.responseSerializer = responseSerializer;
        
#ifdef DEBUG
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
        
    });
    return sharedManager;
}

- (RACSignal *)topStoryIds {
    return [[[self rac_GET:@"topstories.json" parameters:nil] reduceEach:^id(AFHTTPRequestOperation *op, NSArray *response) {
        return response;
    }] deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}

- (RACSignal *)storyWithId:(NSInteger)storyId {
    NSString *endpoint = [NSString stringWithFormat:@"item/%ld.json", storyId];
    return [[[self rac_GET:endpoint parameters:nil] reduceEach:^id (AFHTTPRequestOperation *op, NSDictionary *response) {
        return response;
    }] deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}

- (RACSignal *)topStoriesSync {
    NSMutableArray *stories = [[NSMutableArray alloc] init];
    
    id response = [self syncGET:@"topstories.json" parameters:nil operation:nil error:nil];
    if (response) {
        for (NSNumber *storyId in (NSArray *)response) {
            NSString *endpoint = [NSString stringWithFormat:@"item/%ld.json", [storyId integerValue]];
            id storyObj = [self syncGET:endpoint parameters:nil operation:nil error:nil];
            Story *story = [[Story alloc] initWithAPIResponse:storyObj];
            [stories addObject:story];
            NSLog(@"Service - Story received: %ld", [stories count]);
            if ([stories count] >= 30) {
                return [RACSignal return:stories];
            }
        }
    }
    return [RACSignal return:stories];
}

//- (RACSignal *)topStoriesSync {
//    NSArray *stories = @[
//                         [[Story alloc] initWithId:111
//                                                By:@"newman8r"
//                                             score:48
//                                              time:[NSNumber numberWithInteger:1428990352]
//                                             title:@"111 - Bay Area businessman must pay $136,000 in tech-support scam against elderly"
//                                               url:[NSURL URLWithString:@"https://www.mercurynews.com/2018/06/14/bay-area-businessman-must-pay-136000-in-tech-support-scam-against-elderly/"]],
//                         [[Story alloc] initWithId:222
//                                                By:@"spking"
//                                             score:78
//                                              time:[NSNumber numberWithInteger:1428990352]
//                                             title:@"222 - 50 Worst U.S. Cities to Live In"
//                                               url:[NSURL URLWithString:@"https://www.usatoday.com/story/money/economy/2018/06/13/50-worst-cities-to-live-in/35909271/"]],
//                         [[Story alloc] initWithId:333
//                                                By:@"newman8r"
//                                             score:48
//                                              time:[NSNumber numberWithInteger:1428990352]
//                                             title:@"333 - Bay Area businessman must pay $136,000 in tech-support scam against elderly"
//                                               url:[NSURL URLWithString:@"https://www.mercurynews.com/2018/06/14/bay-area-businessman-must-pay-136000-in-tech-support-scam-against-elderly/"]],
//                         [[Story alloc] initWithId:444
//                                                By:@"spking"
//                                             score:78
//                                              time:[NSNumber numberWithInteger:1428990352]
//                                             title:@"444 - 50 Worst U.S. Cities to Live In"
//                                               url:[NSURL URLWithString:@"https://www.usatoday.com/story/money/economy/2018/06/13/50-worst-cities-to-live-in/35909271/"]],
//                         ];
//    return [[RACSignal return:stories] delay:1];
//}

@end

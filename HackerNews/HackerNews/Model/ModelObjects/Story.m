//
//  Story.m
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "Story.h"

@implementation Story

- (instancetype)initWithId:(NSInteger)storyId
                        By:(NSString *)by
                     score:(NSInteger)score
                      time:(NSNumber *)time
                     title:(NSString *)title
                       url:(NSURL *)url {
    if (self = [super init]) {
        _identifier = storyId;
        _by = by;
        _score = score;
        _time = time;
        _title = title;
        _url = url;
    }
    return self;
}

- (instancetype)initWithAPIResponse:(NSDictionary *)response {
    if (self = [super init]) {
        _by = response[@"by"];
        _descendants = [response[@"descendants"] integerValue];
        _identifier = [response[@"id"] integerValue];
        _score = [response[@"score"] integerValue];
        _time = [NSNumber numberWithInt:[response[@"time"] intValue]];
        _title = response[@"title"];
        _url = [NSURL URLWithString:response[@"url"]];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"StoryId=%ld; Title=%@", self.identifier, self.title];
}

@end

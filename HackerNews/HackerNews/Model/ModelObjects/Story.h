//
//  Story.h
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (strong, nonatomic) NSString *by;
@property (nonatomic) NSInteger descendants;
@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSNumber *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;

- (instancetype)initWithAPIResponse:(NSDictionary *)response;

- (instancetype)initWithId:(NSInteger)storyId
                        By:(NSString *)by
                     score:(NSInteger)score
                      time:(NSNumber *)time
                     title:(NSString *)title
                       url:(NSURL *)url;

@end

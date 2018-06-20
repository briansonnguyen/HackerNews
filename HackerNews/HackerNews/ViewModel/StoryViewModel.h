//
//  StoryViewModel.h
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"

@interface StoryViewModel : NSObject

- (instancetype)initWithStory:(Story *)story;

- (NSString *)title;
- (NSURL *)url;

@end

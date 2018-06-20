//
//  DataStore.h
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

@protocol DataStore <NSObject>

- (void)saveStoryWithId:(NSInteger)storyId;
- (BOOL)getReadStateForStory:(NSInteger)storyId;

@end

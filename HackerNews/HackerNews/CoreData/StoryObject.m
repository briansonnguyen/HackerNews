//
//  StoryObject.m
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "StoryObject.h"

@implementation StoryObject

@dynamic storyId;
@dynamic note;

+ (NSFetchRequest<StoryObject *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"Stories"];
}

@end

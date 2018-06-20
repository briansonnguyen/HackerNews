//
//  DataStoreImpl.m
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "DataStoreImpl.h"
#import "AppDelegate.h"
#import "StoryObject.h"
#import "Story.h"


@interface DataStoreImpl()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end


@implementation DataStoreImpl

- (id)init {
    if (self = [super init]) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

+ (id)sharedManager {
    static DataStoreImpl *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark -

- (void)saveStoryWithId:(NSInteger)storyId {
    StoryObject *newStory = [NSEntityDescription insertNewObjectForEntityForName:@"Stories" inManagedObjectContext:_managedObjectContext];
    newStory.storyId = [NSString stringWithFormat:@"%ld", storyId];
    
    NSError *error;
    [_managedObjectContext save:&error];
    if (error) {
        NSLog(@"DataStore - saveStoryWithId - Error - %@", [error localizedDescription]);
    }
}

- (Story *)getStoryById:(NSInteger)storyId {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Stories"];
    request.predicate = [NSPredicate predicateWithFormat:@"storyId == %ld", storyId];
    NSError *error;
    NSArray *fetchedStories = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"DataStore - getStoryById - Error - %@", [error localizedDescription]);
    }
    else if ([fetchedStories count] > 0) {
        StoryObject *storyObject = [fetchedStories lastObject];
        Story *story = [Story new];
        story.identifier = [storyObject.storyId integerValue];
        if (storyObject.note != nil)
            story.note = [NSString stringWithString:storyObject.note];
        
        return story;
    }
    return nil;
}

- (BOOL)getReadStateForStory:(NSInteger)storyId {
    Story *story = [self getStoryById:storyId];
    return (story) ? YES : NO;
}

@end

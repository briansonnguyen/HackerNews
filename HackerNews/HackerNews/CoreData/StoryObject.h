//
//  StoryObject.h
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface StoryObject : NSManagedObject

+ (NSFetchRequest<StoryObject *> *)fetchRequest;

@property (nonatomic, retain) NSString *storyId;
@property (nonatomic, retain) NSString *note;

@end

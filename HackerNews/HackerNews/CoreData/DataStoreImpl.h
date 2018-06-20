//
//  DataStoreImpl.h
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"

@interface DataStoreImpl : NSObject<DataStore>

+ (id)sharedManager;

@end

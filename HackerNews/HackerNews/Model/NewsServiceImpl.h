//
//  NewsServiceImpl.h
//  HackerNews
//
//  Created by SonNguyen on 6/19/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "NewsService.h"

@interface NewsServiceImpl : AFHTTPRequestOperationManager <NewsService>

+ (id)sharedManager;

@end

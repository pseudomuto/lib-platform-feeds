//
//  PlatformCategoryFeedParser.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformCategoryFeed.h"
#import "PlatformCategory.h"

@implementation PlatformCategoryFeed

- (id)parseEntry:(id)entryObject
{
    PlatformCategory *obj = [[PlatformCategory alloc] init];
    
    obj.id = [entryObject objectForKey:@"id"];
    obj.title = [entryObject objectForKey:@"title"];
    obj.description = [entryObject objectForKey:@"description"];
    obj.fullTitle = [entryObject objectForKey:@"fullTitle"];
    obj.order = [NSNumber numberWithLong:[[entryObject objectForKey:@"order"] longValue]];
    
    return obj;
}

@end

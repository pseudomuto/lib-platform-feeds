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
    return [[PlatformCategory alloc] initWithJSON:entryObject];
}

@end

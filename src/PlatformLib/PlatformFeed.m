//
//  PlatformFeed.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformFeed.h"

@implementation PlatformFeed

- (id)initWithJSON:(id)jsonFeed
{
    if((self = [super init])) {
        if (!jsonFeed) {
            [NSException raise:@"Bad feed data" format:@"jsonFeed cannot be nil"];
        }
        [self parseFeed:jsonFeed];
    }
    
    return self;
}

# pragma mark - "Protected" methods

- (void)parseFeed:(id)jsonFeed
{
    [jsonFeed enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([key isEqualToString:@"entries"]) {
            NSMutableArray *items = [NSMutableArray array];
            for (id item in obj) {
                [items addObject:[self parseEntry:item]];
            }
            
            _entries = items;
        } else if ([key isEqualToString:@"$xmlns"]) {
            _namespaces = obj;
        } else {
            SuppressPerformSelectorLeakWarning(
                SEL whichOne = NSSelectorFromString(key);
                [self performSelector:whichOne withObject:obj];
            );
        }
    }];
}

- (id)parseEntry:(id)entryObject
{
    @throw @"Not Implemented";
}

@end
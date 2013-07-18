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
        _jsonFeed = jsonFeed;
    }
    
    return self;
}

# pragma mark - Public Properties

- (NSDictionary *)namespaces
{
    return [_jsonFeed objectForKey:@"$xmlns"];
}

- (NSNumber *)startIndex
{
    return [NSNumber numberWithInteger:[[_jsonFeed objectForKey:@"startIndex"] integerValue]];
}

- (NSNumber *)itemsPerPage
{
    return [NSNumber numberWithInteger:[[_jsonFeed objectForKey:@"itemsPerPage"] integerValue]];
}

- (NSNumber *)entryCount
{
    return [NSNumber numberWithInteger:[[_jsonFeed objectForKey:@"entryCount"] integerValue]];
}

- (NSString *)title
{
    return [_jsonFeed objectForKey:@"title"];
}

- (NSString *)author
{
    return [_jsonFeed objectForKey:@"author"];
}

@end

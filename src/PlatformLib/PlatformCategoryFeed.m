//
//  PlatformCategoryFeedParser.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformCategoryFeed.h"

@interface PlatformCategoryFeed ()
@property (nonatomic, copy) id jsonFeed;
@end

@implementation PlatformCategoryFeed

- (id)initWithJSON:(id)jsonFeed
{
    if((self = [super init])) {
        self.jsonFeed = jsonFeed;
    }
    
    return self;
}

# pragma mark - Public Properties

- (NSNumber *)startIndex
{
    return [NSNumber numberWithInteger:[[self.jsonFeed objectForKey:@"startIndex"] integerValue]];
}

- (NSNumber *)itemsPerPage
{
    return [NSNumber numberWithInteger:[[self.jsonFeed objectForKey:@"itemsPerPage"] integerValue]];
}

- (NSNumber *)entryCount
{
    return [NSNumber numberWithInteger:[[self.jsonFeed objectForKey:@"entryCount"] integerValue]];
}

- (NSString *)title
{
    return [self.jsonFeed objectForKey:@"title"];
}

- (NSString *)author
{
    return [self.jsonFeed objectForKey:@"author"];
}

@end

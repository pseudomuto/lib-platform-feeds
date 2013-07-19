//
//  PlatformFeed.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformFeed : NSObject 

@property (nonatomic, strong) NSDictionary *namespaces;
@property (nonatomic, strong) NSNumber *startIndex;
@property (nonatomic, strong) NSNumber *itemsPerPage;
@property (nonatomic, strong) NSNumber *entryCount;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSArray *entries;

- (id)initWithJSON:(id)jsonFeed;

// @protected methods

- (void)parseFeed:(id)jsonFeed;
- (id)parseEntry:(id)entryObject;

@end

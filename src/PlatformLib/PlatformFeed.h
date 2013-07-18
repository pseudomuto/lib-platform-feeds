//
//  PlatformFeed.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformFeed : NSObject {

@protected
    id _jsonFeed;
}

@property (nonatomic, readonly) NSDictionary *namespaces;
@property (nonatomic, readonly) NSNumber *startIndex;
@property (nonatomic, readonly) NSNumber *itemsPerPage;
@property (nonatomic, readonly) NSNumber *entryCount;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *author;

- (id)initWithJSON:(id)jsonFeed;

@end

//
//  PlatformRequest.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformRequest : NSObject {
    @protected
    __strong NSString *_endPoint;
}

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID;

- (NSURLRequest *)makeRequest;
- (void)setParameterValue:(id)value forKey:(NSString *)key;

@end

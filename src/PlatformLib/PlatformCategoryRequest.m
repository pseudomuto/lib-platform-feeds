//
//  PlatformCategoryRequest.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformCategoryRequest.h"

@implementation PlatformCategoryRequest

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID
{
    if((self = [super initWithAccount:accountPID andFeed:feedPID])) {
        _endPoint = @"/categories";
    }
    
    return self;
}

@end

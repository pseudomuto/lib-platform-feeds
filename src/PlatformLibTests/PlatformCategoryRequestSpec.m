//
//  PlatformCategoryRequestSpec.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformCategoryRequest.h"

SPEC_BEGIN(PlatformCategoryRequestSpec)

describe(@"PlatformCategoryRequest", ^{
    
    describe(@"- makeRequest", ^{
        
        it(@"uses the correct endpoint", ^{
            NSURLRequest *subject = [[[PlatformCategoryRequest alloc] initWithAccount:@"account" andFeed:@"feed"] makeRequest];
            [[subject.URL.path should] equal:@"/account/feed/categories"];
        });
    });
});

SPEC_END

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
        
        context(@"common properties", ^{
            NSURLRequest *_subject = [[[PlatformCategoryRequest alloc] initWithAccount:@"account" andFeed:@"feed"] makeRequest];
            
            it(@"uses the GET method", ^{
                [[_subject.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"uses the correct host", ^{
                [[_subject.URL.host should] equal:@"feed.theplatform.com"];
            });
            
            it(@"uses the correct path", ^{
                [[_subject.URL.path should] equal:@"/account/feed/categories"];
            });
        });
        
        context(@"with no parameters", ^{
            NSURLRequest *_subject = [[[PlatformCategoryRequest alloc] initWithAccount:@"account" andFeed:@"feed"] makeRequest];
            
            it(@"leaves querystring nil", ^{
                [[_subject.URL.query should] beNil];
            });
        });
        
        context(@"with parameters", ^{
            NSURLRequest *_subject = ^{
                PlatformCategoryRequest *r = [[PlatformCategoryRequest alloc] initWithAccount:@"account" andFeed:@"feed"];
                [r setParameterValue:@"fullTitle|asc" forKey:@"sort"];
                [r setParameterValue:@"true" forKey:@"byHasReleases"];
                
                return [r makeRequest];
            }();
            
            it(@"set the querystring value", ^{
                [[theValue([_subject.URL.path rangeOfString:@"?"].location) shouldNot] equal:theValue(NSNotFound)];
            });
            
            it(@"adds parameters to query string", ^{
                NSRange range = [_subject.URL.path rangeOfString:@"byHasReleases=true"];
                [[theValue(range.location) shouldNot] equal:theValue(NSNotFound)];
                
                range = [_subject.URL.path rangeOfString:@"sort=fullTitle|asc"];
                [[theValue(range.location) shouldNot] equal:theValue(NSNotFound)];
            });
        });
    });
});

SPEC_END

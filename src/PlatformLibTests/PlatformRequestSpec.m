//
//  PlatformRequestSpec.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-22.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformRequest.h"

SPEC_BEGIN(PlatformRequestSpec)

describe(@"PlatformRequest", ^{
    
    describe(@"- initWithAccount:andFeed:", ^{
        
        context(@"with valid parameters", ^{
            PlatformRequest *_subject = [[PlatformRequest alloc] initWithAccount:@"account" andFeed:@"feed"];
            
            it(@"creates instance", ^{
                [[_subject shouldNot] beNil];
            });
        });
        
        context(@"with bad parameters", ^{
            
            it(@"throws when account id not valid", ^{
               [[theBlock(^{
                   PlatformRequest *obj __attribute__((unused)) = [[PlatformRequest alloc] initWithAccount:nil andFeed:@"some_feed"];
               }) should] raise];
            });
            
            it(@"throws when feed id not valid", ^{
                [[theBlock(^{
                    PlatformRequest *obj __attribute__((unused)) = [[PlatformRequest alloc] initWithAccount:@"account" andFeed:@""];
                }) should] raise];
            });
        });
    });
    
    describe(@"- clearParameters", ^{
        
        it(@"removes any parameters", ^ {
            PlatformRequest *r = [[PlatformRequest alloc] initWithAccount:@"account" andFeed:@"feed"];
            [r setParameterValue:@"fullTitle|asc" forKey:@"sort"];
            [r setParameterValue:@"true" forKey:@"byHasReleases"];
            [r clearParameters];
            
            [[theValue([[r makeRequest].URL.path rangeOfString:@"?"].location) should] equal:theValue(NSNotFound)];
        });
    });
    
    describe(@"- makeRequest", ^{
        
        context(@"common properties", ^{
            NSURLRequest *_subject = [[[PlatformRequest alloc] initWithAccount:@"account" andFeed:@"feed"] makeRequest];
            
            it(@"uses the GET method", ^{
                [[_subject.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"uses the correct host", ^{
                [[_subject.URL.host should] equal:@"feed.theplatform.com"];
            });
            
            it(@"uses the correct path", ^{
                [[_subject.URL.path should] equal:@"/account/feed"];
            });
        });
        
        context(@"with no parameters", ^{
            NSURLRequest *_subject = [[[PlatformRequest alloc] initWithAccount:@"account" andFeed:@"feed"] makeRequest];
            
            it(@"leaves querystring nil", ^{
                [[_subject.URL.query should] beNil];
            });
        });
        
        context(@"with parameters", ^{
            NSURLRequest *_subject = ^{
                PlatformRequest *r = [[PlatformRequest alloc] initWithAccount:@"account" andFeed:@"feed"];
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
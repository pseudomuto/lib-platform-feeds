//
//  PlatformFeedSpec.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-22.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformCategoryFeed.h"

SPEC_BEGIN(PlatformFeedSpec)

describe(@"PlatformFeed", ^{
    
    PlatformFeed *_subject = ^{
        NSString *jsonResponse = @"{\"$xmlns\":{\"pl1\":\"http://access.auth.theplatform.com/data/Account/2269680845\"},\"startIndex\":1,\"itemsPerPage\":500,\"entryCount\":500,\"title\":\"Feeds3 Feed\",\"author\":\"David Muto\",\"entries\":[{\"id\":\"http://data.media.theplatform.com/media/data/Category/37717571913\",\"title\":\"I'm Having Their Baby\",\"description\":\"\",\"fullTitle\":\"I'm Having Their Baby\",\"order\":2147483647,\"pl1$showStatus\":\"available\"}]}";
        
        NSData *json = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        
        PlatformFeed *feed = [[PlatformCategoryFeed alloc] initWithJSON:jsonObject];
        return feed;
    }();
    
    describe(@"- initWithJSON:", ^{
    
        it(@"initializes a new instance", ^{
            [[_subject shouldNot] beNil];
        });
        
        it(@"throws when passed nil", ^{
            [[theBlock(^{
                PlatformFeed *client __attribute__((unused)) = [[PlatformFeed alloc] initWithJSON:nil];
            }) should] raise];
        });
    });
    
    describe(@"- namespaces", ^{
        
        it(@"is a dictionary", ^{
            [[_subject.namespaces should] beKindOfClass:[NSDictionary class]];
        });
        
        it(@"loads values from feed", ^{
            [[[_subject.namespaces objectForKey:@"pl1"] should] equal:@"http://access.auth.theplatform.com/data/Account/2269680845"];
        });
    });
    
    describe(@"- startIndex", ^{
        
        it(@"pulls value from feed", ^{
            [[_subject.startIndex should] equal:theValue(1)];
        });
    });
    
    describe(@"- itemsPerPage", ^{
        
        it(@"pulls value from feed", ^{
            [[_subject.itemsPerPage should] equal:theValue(500)];
        });
    });
    
    describe(@"- entryCount", ^{
        
        it(@"pulls value from feed", ^{
            [[_subject.entryCount should] equal:theValue(500)];
        });
    });
    
    describe(@"- title", ^{
        
        it(@"pulls value from feed", ^{
            [[_subject.title should] equal:@"Feeds3 Feed"];
        });
    });
    
    describe(@"- author", ^{
        
        it(@"pulls value from feed", ^{
            [[_subject.author should] equal:@"David Muto"];
        });
    });
    
    describe(@"- entries", ^{
        
        it(@"is an array", ^{
            [[_subject.entries should] beKindOfClass:[NSArray class]];
        });
        
        it(@"pulls values from feed", ^{
            [[theValue(_subject.entries.count) should] beGreaterThan:theValue(0)];
        });
    });
});

SPEC_END

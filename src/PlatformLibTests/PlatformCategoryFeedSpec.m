//
//  PlatformCategoryFeedParser.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformLib.h"
#include "PlatformCategoryFeed.h"

SPEC_BEGIN(PlatformCategoryFeedSpec)

describe(@"PlatformCategoryFeed", ^{

    PlatformCategoryFeed *_subject = ^{
        NSString *jsonResponse = @"{\"$xmlns\":{\"pl1\":\"http://access.auth.theplatform.com/data/Account/2269680845\"},\"startIndex\":1,\"itemsPerPage\":500,\"entryCount\":500,\"title\":\"Feeds3 Feed\",\"author\":\"David Muto\",\"entries\":[{\"id\":\"http://data.media.theplatform.com/media/data/Category/37717571913\",\"title\":\"I'm Having Their Baby\",\"description\":\"\",\"fullTitle\":\"I'm Having Their Baby\",\"order\":2147483647,\"pl1$showStatus\":\"available\"}]}";
        
        NSData *json = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        
        return [[PlatformCategoryFeed alloc] initWithJSON:jsonObject];
    }();

    describe(@"- initWithJSON:", ^{
        
        it(@"initializes a new instance", ^{
            [[_subject shouldNot] beNil];
        });
        
        it(@"throws when passed nil", ^{
            [[theBlock(^{
                PlatformCategoryFeed *client __attribute__((unused)) = [[PlatformCategoryFeed alloc] initWithJSON:nil];
            }) should] raise];
        });
    });

    describe(@"- entries", ^{
        
        it(@"pulls values from feed", ^{
            [[theValue(_subject.entries.count) should] beGreaterThan:theValue(0)];
        });
        
        it(@"creates entries of the right type", ^{
            [[[_subject.entries objectAtIndex:0] should] beKindOfClass:[PlatformCategory class]];
        });
    });
});

SPEC_END
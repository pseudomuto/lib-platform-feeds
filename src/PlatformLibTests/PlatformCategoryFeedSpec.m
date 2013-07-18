//
//  PlatformCategoryFeedParser.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformCategoryFeed.h"

static NSString *const PlatformCategoryFeedJSON = @"{\"$xmlns\":{\"pl1\":\"http://access.auth.theplatform.com/data/Account/2269680845\"},\"startIndex\":1,\"itemsPerPage\":500,\"entryCount\":500,\"title\":\"Feeds3 Feed\",\"author\":\"David Muto\",\"entries\":[{\"id\":\"http://data.media.theplatform.com/media/data/Category/37717571913\",\"title\":\"I'm Having Their Baby\",\"description\":\"\",\"fullTitle\":\"I'm Having Their Baby\",\"order\":2147483647,\"pl1$showStatus\":\"available\"}]}";

PlatformCategoryFeed *makeFeed()
{
    NSData *json = [PlatformCategoryFeedJSON dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    
    return [[PlatformCategoryFeed alloc] initWithJSON:jsonObject];
}

SPEC_BEGIN(PlatformCategoryFeedSpec)

describe(@"- initWithJSON:", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"succeeds", ^{
        [[_subject shouldNot] beNil];
    });
});

describe(@"- namespaces", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"is a dictionary", ^{
        [[_subject.namespaces should] beKindOfClass:[NSDictionary class]];
    });
    
    it(@"loads values from feed", ^{
        [[[_subject.namespaces objectForKey:@"pl1"] shouldNot] beNil];
    });
});

describe(@"- startIndex", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"pulls value from feed", ^{
        [[_subject.startIndex should] equal:theValue(1)];
    });
});

describe(@"- itemsPerPage", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"pulls value from feed", ^{
        [[_subject.itemsPerPage should] equal:theValue(500)];
    });
});

describe(@"- entryCount", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"pulls value from feed", ^{
        [[_subject.entryCount should] equal:theValue(500)];
    });
});

describe(@"- title", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"pulls value from feed", ^{
        [[_subject.title should] equal:@"Feeds3 Feed"];
    });
});

describe(@"- author", ^{
    PlatformCategoryFeed *_subject = makeFeed();
    
    it(@"pulls value from feed", ^{
        [[_subject.author should] equal:@"David Muto"];
    });
});

SPEC_END
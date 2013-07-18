//
//  PlatformCategoryFeedParser.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-18.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformCategoryFeed.h"

SPEC_BEGIN(PlatformCategoryFeedSpec)

static NSString *const PlatformCategoryFeedJSON = @"{\"$xmlns\":{\"pl1\":\"http://access.auth.theplatform.com/data/Account/2269680845\"},\"startIndex\":1,\"itemsPerPage\":500,\"entryCount\":500,\"title\":\"Feeds3 Feed\",\"author\":\"David Muto\",\"entries\":[{\"id\":\"http://data.media.theplatform.com/media/data/Category/37717571913\",\"title\":\"I'm Having Their Baby\",\"description\":\"\",\"fullTitle\":\"I'm Having Their Baby\",\"order\":2147483647,\"pl1$showStatus\":\"available\"}]}";

describe(@"- initWithJSON:", ^{
    
    PlatformCategoryFeed *_subject = [[PlatformCategoryFeed alloc] initWithJSON:@"Some Object"];
    
    it(@"retains object", ^{
        [[[_subject performSelector:@selector(jsonFeed)] shouldNot] beNil];
    });
});

describe(@"Top Level Properties", ^{
    __block PlatformCategoryFeed *_subject;
   
    beforeEach(^{
        NSData *json = [PlatformCategoryFeedJSON dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        
        _subject = [[PlatformCategoryFeed alloc] initWithJSON:jsonObject];
    });
    
    it(@"- pulls startIndex from feed", ^{
        [[_subject.startIndex should] equal:theValue(1)];
    });
    
    it(@"- pulls itemsPerPage from feed", ^{
        [[_subject.itemsPerPage should] equal:theValue(500)];
    });
    
    it(@"- pulls entryCount from feed", ^{
        [[_subject.entryCount should] equal:theValue(500)];
    });
    
    it(@"- pulls title from feed", ^{
        [[_subject.title should] equal:@"Feeds3 Feed"];
    });
    
    it(@"- pulls author from feed", ^{
        [[_subject.author should] equal:@"David Muto"];
    });
});

SPEC_END
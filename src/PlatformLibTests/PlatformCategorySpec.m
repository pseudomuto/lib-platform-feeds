//
//  PlatformCategorySpec.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#include "Kiwi.h"
#include "PlatformLib.h"

SPEC_BEGIN(PlatformCategorySpec)

describe(@"PlatformCategory", ^{
    
    PlatformCategory *_category = ^{
        NSString *jsonResponse = @"{\"id\":\"http://data.media.theplatform.com/media/data/Category/37717571913\",\"title\":\"I'm Having Their Baby\",\"description\":\"\",\"fullTitle\":\"I'm Having Their Baby\",\"order\":2147483647,\"pl1$showStatus\":\"available\"}";
        
        NSData *json = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        
        return [[PlatformCategory alloc] initWithJSON:jsonObject];
    }();
   
    describe(@"- initWithJSON:", ^{
       
        it(@"parses category id", ^{
            [[_category.category_id shouldNot] beNil];
            [[_category.category_id should] equal:@"http://data.media.theplatform.com/media/data/Category/37717571913"];
        });
        
        it(@"parses category title", ^{
            [[_category.title shouldNot] beNil];
            [[_category.title should] equal:@"I'm Having Their Baby"];
        });
        
        it(@"parses category description", ^{
            [[_category.description shouldNot] beNil];
            [[_category.description should] equal:@""];
        });
        
        it(@"parses category fullTitle", ^{
            [[_category.fullTitle shouldNot] beNil];
            [[_category.fullTitle should] equal:@"I'm Having Their Baby"];
        });
        
        it(@"parses category order", ^{
            [[_category.order shouldNot] beNil];
            [[_category.order should] equal:theValue(2147483647)];
        });
        
        it(@"parses custom property", ^{
            [[[_category.properties objectForKey:@"showStatus"] shouldNot] beNil];
            [[[_category.properties objectForKey:@"showStatus"] should] equal:@"available"];
        });
        
        it(@"defaults hasReleases to NO", ^{
            [[theValue(_category.hasReleases) should] beNo];
        });
    });
});

SPEC_END

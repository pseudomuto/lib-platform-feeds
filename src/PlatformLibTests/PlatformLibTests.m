//
//  PlatformLibTests.m
//  PlatformLibTests
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(LIB_SPEC)

//describe(@"Something", ^{
//    
//    it(@"Does fail", ^{
//        NSInteger a = 16;
//        NSInteger b = 26;
//        [[theValue(a + b) should] equal:theValue(43)];
//    });
//});

describe(@"Failure", ^{
    it(@"Fails", ^{
        [[theValue(YES) should] equal:theValue(NO)];
    });
});

SPEC_END
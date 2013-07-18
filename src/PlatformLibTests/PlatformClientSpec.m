//
//  PlatformClientSpec.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "Kiwi.h"
#import "PlatformLib.h"

SPEC_BEGIN(PlatformClientSpec)

describe(@"PlatformClient", ^{
    
    describe(@"- initWithAccount:andFeed:", ^{
        
        context(@"when passed valid arguments", ^{
            PlatformClient *client = [[PlatformClient alloc] initWithAccount:@"account" andFeed:@"feed"];
            
            it(@"retains account PID", ^{
                [[client.accountPID should] equal:@"account"];
            });
            
            it(@"retains feed PID", ^{
                [[client.feedPID should] equal:@"feed"];
            });
        });
        
        context(@"when passed invalid arguments", ^{
            
            it(@"raises with bad account PID", ^{
                [[theBlock(^{
                    PlatformClient *client __attribute__((unused)) = [[PlatformClient alloc] initWithAccount:@"" andFeed:@"feed"];
                }) should] raise];
            });
            
            it(@"raises with bad feed PID", ^{
                [[theBlock(^{
                    PlatformClient *client __attribute__((unused)) = [[PlatformClient alloc] initWithAccount:@"account" andFeed:@""];
                }) should] raise];
            });
        });
    });
    
    describe(@"- getCategoriesOnCompletion", ^{
        
        context(@"when call fails", ^{
            PlatformClient *client = [[PlatformClient alloc] initWithAccount:@"account" andFeed:@"feed"];
            
            beforeEach(^{
                // stub method
                id mock = [KWMock mockForProtocol:@protocol(PlatformClientDataSource)];
                [mock stub:@selector(responseWithEntriesForURL:) withBlock:^id(NSArray *params) {
                    [NSException raise:@"Bad URL" format:@"Get outta here!!"];
                    return nil;
                }];
                
                client.dataSource = mock;
            });
        });
    });
    
});

SPEC_END
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
        
        context(@"when call succeeds", ^{
            id mock = [KWMock mockForProtocol:@protocol(PlatformClientDataSource)];
            PlatformClient *client = [[PlatformClient alloc] initWithAccount:@"account" andFeed:@"feed"];
            
            beforeEach(^{
                [mock stub:@selector(responseWithEntriesForURL:success:failure:) withBlock:^id(NSArray *params) {
                    // simulate success by calling success block
                    PlatformClientResponseBlock success = [params objectAtIndex:1];
                    success(nil, nil, nil);
                    return nil;
                }];
                
                client.dataSource = mock;
            });
            
            it(@"delegates call dataSource", ^{
                [[mock shouldEventually] receive:@selector(responseWithEntriesForURL:success:failure:)];
                [client getCategoriesWithBlock:nil failure:nil];
            });
            
            it(@"executes the success block", ^{
                __block BOOL called = NO;
                
                PlatformClientResultBlock successBlock = ^(NSArray *err) {
                    called = YES;
                };
                
                [client getCategoriesWithBlock:successBlock failure:nil];
                [[expectFutureValue(theValue(called)) shouldEventuallyBeforeTimingOutAfter(1.f)] beYes];
            });
        });
        
        context(@"when call fails", ^{
            id mock = [KWMock mockForProtocol:@protocol(PlatformClientDataSource)];
            PlatformClient *client = [[PlatformClient alloc] initWithAccount:@"account" andFeed:@"feed"];
            
            beforeEach(^{
                [mock stub:@selector(responseWithEntriesForURL:success:failure:) withBlock:^id(NSArray *params) {
                    // simulate failure by calling error block
                    PlatformClientResponseErrorBlock err = [params objectAtIndex:2];
                    err(nil, nil, nil, nil);
                    return nil;
                }];
                
                client.dataSource = mock;
            });
            
            it(@"delegates call dataSource", ^{
                [[mock shouldEventually] receive:@selector(responseWithEntriesForURL:success:failure:)];
                [client getCategoriesWithBlock:nil failure:nil];
            });
            
            it(@"executes the error block", ^{
                __block BOOL called = NO;
                
                PlatformClientErrorBlock errorBlock = ^(NSError *err) {
                    called = YES;
                };
                
                [client getCategoriesWithBlock:nil failure:errorBlock];
                [[expectFutureValue(theValue(called)) shouldEventuallyBeforeTimingOutAfter(1.f)] beYes];
            });
        });
    });
    
});

SPEC_END
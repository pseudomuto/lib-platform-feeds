//
//  PlatformClient.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PlatformClientResponseBlock)(NSURLRequest *, NSURLResponse *, id);
typedef void (^PlatformClientResponseErrorBlock)(NSURLRequest *, NSURLResponse *, NSError *, id);

typedef void (^PlatformClientResultBlock)(NSArray *);
typedef void (^PlatformClientErrorBlock)(NSError *);

@protocol PlatformClientDataSource <NSObject>

- (NSArray *)responseWithEntriesForURL:(NSURL *)url
                               success:(PlatformClientResponseBlock)successBlock
                               failure:(PlatformClientResponseErrorBlock)errorBlock;

@end

@interface PlatformClient : NSObject

@property (nonatomic, readonly, strong) NSString *accountPID;
@property (nonatomic, readonly, strong) NSString *feedPID;
@property (nonatomic, assign) id<PlatformClientDataSource> dataSource;

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID;

- (void)getCategoriesWithBlock:(PlatformClientResultBlock)success
                       failure:(PlatformClientErrorBlock)failure;

@end

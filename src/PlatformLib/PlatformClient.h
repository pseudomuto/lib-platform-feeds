//
//  PlatformClient.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PlatformClientResultBlock)(NSArray *items);
typedef void (^PlatformClientErrorBlock)(void);

@protocol PlatformClientDataSource <NSObject>

- (NSArray *)responseWithEntriesForURL:(NSURL *)url;

@end

@interface PlatformClient : NSObject

@property (nonatomic, readonly, strong) NSString *accountPID;
@property (nonatomic, readonly, strong) NSString *feedPID;
@property (nonatomic, assign) id<PlatformClientDataSource> dataSource;

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID;

- (void)getCategoriesOnCompletion:(PlatformClientResultBlock)complete
                          onError:(PlatformClientErrorBlock)error;

@end

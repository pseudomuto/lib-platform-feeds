//
//  PlatformClient.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformClient.h"

static NSString *const kMissingAccountPIDMessage = @"Account PID must be supplied";
static NSString *const kMissingFeedPIDMessage = @"Feed PID must be supplied";

@interface PlatformClient ()

- (void)validate:(NSString *)value withMessage:(NSString *)message;
- (void)getEntriesForPath:(NSString *)virtualPath success:(PlatformClientResponseBlock)success failure:(PlatformClientResponseErrorBlock)failure;
@end

@implementation PlatformClient

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID
{
    if((self = [super init])) {
        _accountPID = accountPID;
        _feedPID = feedPID;
        
        [self validate:_accountPID withMessage:kMissingAccountPIDMessage];
        [self validate:_feedPID withMessage:kMissingFeedPIDMessage];
    }
    
    return self;
}

# pragma mark - Properties

- (id<PlatformClientDataSource>)dataSource
{
    if(!_dataSource) {
        // TODO: create a default instance
    }
    
    return _dataSource;
}


# pragma mark - Public methods

- (void)getCategoriesWithBlock:(PlatformClientResultBlock)success
                       failure:(PlatformClientErrorBlock)failure
{
    PlatformClientResponseBlock successBlock = ^(NSURLRequest *req, NSURLResponse *resp, id json) {
        if (!success) return;
        
        NSArray *items = [json objectForKey:@"entries"];

        // TODO: Make correct type
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(items);
        });
    };
    
    PlatformClientResponseErrorBlock failureBlock = ^(NSURLRequest *req, NSURLResponse *resp, NSError *err, id json) {
        if (!failure) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(err);
        });
    };
    
    [self getEntriesForPath:@"" success:successBlock failure:failureBlock];
}

# pragma mark - Private methods

- (void)validate:(NSString *)value withMessage:(NSString *)message
{
    if(!value || [value isEqualToString:@""]) {
        [NSException raise:@"InvalidArgumentException" format:@"%@", message];
    }
}

- (void)getEntriesForPath:(NSString *)virtualPath
                  success:(PlatformClientResponseBlock)success
                  failure:(PlatformClientResponseErrorBlock)failure
{
    // TODO: Make URL
    
    __weak __typeof__(self) _self = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [_self.dataSource responseWithEntriesForURL:nil
                                            success:success
                                            failure:failure];
    });
}

@end

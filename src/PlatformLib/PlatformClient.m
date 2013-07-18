//
//  PlatformClient.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-17.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformClient.h"

@implementation PlatformClient

- (void)validate:(NSString *)value withMessage:(NSString *)message
{
    if(!value || [value isEqualToString:@""]) {
        [NSException raise:@"InvalidArgumentException" format:message];
    }
}

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID
{
    if((self = [super init])) {
        _accountPID = accountPID;
        _feedPID = feedPID;
        
        [self validate:_accountPID withMessage:@"Account PID must be supplied"];
        [self validate:_feedPID withMessage:@"Feed PID must be supplied"];
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

- (void)getCategoriesOnCompletion:(PlatformClientResultBlock)complete
                          onError:(PlatformClientErrorBlock)error
{
    
}

@end

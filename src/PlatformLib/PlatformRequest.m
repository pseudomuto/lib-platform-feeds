//
//  PlatformRequest.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformRequest.h"

static NSString *const kPlatformHost = @"feed.theplatform.com";

@interface PlatformRequest ()
@property (nonatomic, copy) NSString *accountPID;
@property (nonatomic, copy) NSString *feedPID;
@property (nonatomic, strong) NSMutableDictionary *parameters;

- (NSString *)makeParameters;
- (void)validateArgument:(NSString *)arg withMessage:(NSString *)message;
@end

@implementation PlatformRequest

- (id)initWithAccount:(NSString *)accountPID andFeed:(NSString *)feedPID
{
    if((self = [super init])){
        _endPoint = @"";
        self.accountPID = accountPID;
        self.feedPID = feedPID;
        
        [self validateArgument:self.accountPID withMessage:@"Account Id is not valid"];
        [self validateArgument:self.feedPID withMessage:@"Feed Id is not valid"];
    }
    
    return self;
}

- (void)validateArgument:(NSString *)arg withMessage:(NSString *)message
{
    if(!arg || [arg isEqualToString:@""]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:message userInfo:nil];
    }
}

- (NSMutableDictionary *)parameters
{
    if(!_parameters) {
        _parameters = [NSMutableDictionary new];
    }
    
    return _parameters;
}

- (NSURLRequest *)makeRequest
{
    NSString *path = [NSString stringWithFormat:@"http://%@/%@/%@%@",
                      kPlatformHost,
                      self.accountPID,
                      self.feedPID,
                      _endPoint];
    
    NSString *params = [self makeParameters];
    if(params) {
        path = [path stringByAppendingFormat:@"?%@", params];
    }
    
    NSURL *url = [NSURL URLWithString:path];
    return [NSURLRequest requestWithURL:url];
}

- (void)setParameterValue:(id)value forKey:(NSString *)key
{
    [self.parameters setObject:value forKey:key];
}

# pragma mark - Private Methods

- (NSString *)makeParameters
{
    if(self.parameters.count == 0) return nil;
    
    NSMutableArray *parts = [NSMutableArray array];
    for (NSString *key in self.parameters.allKeys) {
        [parts addObject:[NSString stringWithFormat:@"%@=%@", key, [self.parameters objectForKey:key]]];
    }

    return [parts componentsJoinedByString:@"&"];
}

@end

//
//  PlatformObject.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformObject.h"

@implementation PlatformObject

- (id)initWithJSON:(id)jsonObject
{
    if((self = [super init])) {
        __weak __typeof__(self) _self = self;
        [jsonObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [_self processPropertyName:key andValue:obj];
        }];
    }
    
    return self;
}

- (NSMutableDictionary *)properties
{
    if(!_properties) {
        _properties = [NSMutableDictionary new];
    }
    
    return _properties;
}

- (void)processJsonObject:(id)jsonObject
{
    __weak __typeof__(self) _self = self;
    [jsonObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSRange index = [key rangeOfString:@"$"];
        
        if (index.location != NSNotFound) {
            [_self processCustomProperty:[key substringFromIndex:index.location + 1] withValue:obj];
        }
        else {
            [_self processPropertyName:key andValue:obj];
        }        
    }];
}

- (void)processPropertyName:(NSString *)name andValue:(id)value
{
    NSString *propName = [NSString stringWithFormat:@"%@%@",
                          [[name substringToIndex:1] uppercaseString],
                          [name substringFromIndex:1]];
    
    NSString *selName = [NSString stringWithFormat:@"set%@:", propName];
    NSLog(@"Attempting to call %@", selName);
    
    SEL selector = NSSelectorFromString(selName);
    
    if([self respondsToSelector:selector]) {
        SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:value]);
    }
}

- (void)processCustomProperty:(NSString *)name withValue:(id)value
{
    [self.properties setObject:value forKey:name];
}

@end

//
//  PlatformCategory.m
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import "PlatformCategory.h"

@implementation PlatformCategory

- (id)initWithJSON:(id)jsonObject
{
    if((self = [super initWithJSON:jsonObject])) {
        [self processJsonObject:jsonObject];
    }
    
    return self;
}

- (void)processPropertyName:(NSString *)name andValue:(id)value
{
    if ([name isEqualToString:@"id"]) {
        self.category_id = value;
        return;
    }
    
    [super processPropertyName:name andValue:value];
}

@end

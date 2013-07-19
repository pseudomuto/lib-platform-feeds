//
//  PlatformObject.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformObject : NSObject

@property (nonatomic, strong) NSMutableDictionary *properties;

- (id)initWithJSON:(id)jsonObject;

- (void)processJsonObject:(id)jsonObject;
- (void)processPropertyName:(NSString *)name andValue:(id)value;
- (void)processCustomProperty:(NSString *)name withValue:(id)value;
@end

//
//  PlatformCategory.h
//  PlatformLib
//
//  Created by David Muto on 2013-07-19.
//  Copyright (c) 2013 David Muto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlatformObject.h"

@interface PlatformCategory : PlatformObject

@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *fullTitle;
@property (nonatomic, strong) NSNumber *order;

@end

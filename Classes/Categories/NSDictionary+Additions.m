//
//  NSDictionary+NSDictionary_Additions.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (NSDictionary_Additions)

- (instancetype)extendWithDictionary:(NSDictionary *)dict {
    __block NSMutableDictionary *result = [self mutableCopy];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [result setObject:obj forKey:key];
    }];
    
    return [[NSDictionary alloc] initWithDictionary:result];
}

@end

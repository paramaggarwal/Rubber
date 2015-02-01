//
//  TextComponentModel.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "TextComponentModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation TextComponentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{
                                              @"value": @"props.value"
                                              }];
}

@end

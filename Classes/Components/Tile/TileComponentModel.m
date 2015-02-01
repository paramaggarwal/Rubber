//
//  TileComponentModel.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "TileComponentModel.h"
#import "NSDictionary+Additions.h"

@implementation TileComponentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys extendWithDictionary:@{}];
}

@end

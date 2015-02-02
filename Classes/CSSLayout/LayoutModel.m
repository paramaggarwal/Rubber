//
//  LayoutModel.m
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "LayoutModel.h"

@implementation LayoutModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

//- (NSDictionary *)convertToDictionary {
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self.dictionaryValue];
//    
//    [self.children enumerateObjectsUsingBlock:^(LayoutModel *child, NSUInteger index, BOOL *stop) {
//        dict[@"children"][index] = [child convertToDictionary];
//    }];
//    
//    return [dict copy];
//}

@end

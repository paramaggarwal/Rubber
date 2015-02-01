//
//  RBScrollViewModel.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBScrollViewModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation RBScrollViewModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{}];
}

@end

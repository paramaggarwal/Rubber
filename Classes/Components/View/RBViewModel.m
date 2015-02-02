//
//  RBViewModel.m
//  Pods
//
//  Created by Param Aggarwal on 02/02/15.
//
//

#import "RBViewModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation RBViewModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{}];
}

@end

//
//  RBTableViewModel.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableViewModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation RBTableViewModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{}];
}

@end

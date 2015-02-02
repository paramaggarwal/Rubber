//
//  NavigationControllerModel.m
//  Pods
//
//  Created by Param Aggarwal on 02/02/15.
//
//

#import "RBNavigationControllerModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation RBNavigationControllerModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{}];
}

@end

//
//  RBViewControllerModel.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBViewControllerModel.h"
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>

@implementation RBViewControllerModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentKeys = [super JSONKeyPathsByPropertyKey];
    return [parentKeys mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                     @"title": @"props.title"
                                                                     }];
}

@end

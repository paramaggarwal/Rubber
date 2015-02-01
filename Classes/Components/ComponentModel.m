//
//  ComponentModel.m
//  LayoutTest
//
//  Created by Param Aggarwal on 06/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "ComponentModel.h"

#import "TileComponentModel.h"
#import "TextComponentModel.h"
#import "ImageComponentModel.h"
#import "IconComponentModel.h"
#import "SlideshowComponentModel.h"

@implementation ComponentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"style": @"props.style",
             @"href": @"props.href",
             @"needsClickHandler": @"props.needsClickHandler",
             @"needsPanGesture": @"props.needsPanGesture",
             };
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if ([JSONDictionary[@"type"]  isEqual:@"tile"]) {
        return TileComponentModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"text"]) {
        return TextComponentModel.class;
    }

    if ([JSONDictionary[@"type"]  isEqual:@"image"]) {
        return ImageComponentModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"icon"]) {
        return IconComponentModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"slideshow"]) {
        return SlideshowComponentModel.class;
    }

    NSLog(@"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    
    return self;
}

+ (NSValueTransformer *) styleJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StyleModel class]];
}

+ (NSValueTransformer *) childrenJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[self class]];
}

@end

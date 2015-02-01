//
//  StyleModel.m
//  LayoutTest
//
//  Created by Param Aggarwal on 06/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "StyleModel.h"
#import "ColorTransformer.h"

@implementation StyleModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)flexDirectionJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"column": @(StyleFlexDirectionColumn),
                                                                           @"row": @(StyleFlexDirectionRow)
                                                                           } defaultValue:StyleFlexDirectionColumn reverseDefaultValue:@"column"];
}

+ (NSValueTransformer *)justifyContentJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"flex-start": @(StyleJustifyContentFlexStart),
                                                                           @"center": @(StyleJustifyContentCenter),
                                                                           @"flex-end": @(StyleJustifyContentFlexEnd),
                                                                           @"space-between": @(StyleJustifyContentSpaceBetween),
                                                                           @"space-around": @(StyleJustifyContentSpaceAround)
                                                                           } defaultValue:StyleJustifyContentFlexStart reverseDefaultValue:@"flex-start"];
}

+ (NSValueTransformer *)alignItemsJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"stretch": @(StyleFlexAlignStretch),
                                                                           @"flex-start": @(StyleFlexAlignFlexStart),
                                                                           @"center": @(StyleFlexAlignCenter),
                                                                           @"flex-end": @(StyleFlexAlignFlexEnd),
                                                                           } defaultValue:StyleFlexAlignStretch reverseDefaultValue:@"stretch"];
}

+ (NSValueTransformer *)alignSelfJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"stretch": @(StyleFlexAlignStretch),
                                                                           @"flex-start": @(StyleFlexAlignFlexStart),
                                                                           @"center": @(StyleFlexAlignCenter),
                                                                           @"flex-end": @(StyleFlexAlignFlexEnd),
                                                                           } defaultValue:StyleFlexAlignStretch reverseDefaultValue:@"stretch"];
}

+ (NSValueTransformer *)positionJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"relative": @(StylePositionRelative),
                                                                           @"absolute": @(StylePositionAbsolute)
                                                                           } defaultValue:StylePositionRelative reverseDefaultValue:@"relative"];
}

+ (NSValueTransformer *)textAlignJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"left": @(NSTextAlignmentLeft),
                                                                           @"center": @(NSTextAlignmentCenter),
                                                                           @"right": @(NSTextAlignmentRight)
                                                                           } defaultValue:NSTextAlignmentLeft reverseDefaultValue:@"left"];
}

+ (NSValueTransformer *)backgroundPositionJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"center center": @(BackgroundImagePositionCenter),
                                                                           @"left top": @(BackgroundImagePositionLeftTop),
                                                                           @"center top": @(BackgroundImagePositionTop),
                                                                           @"right top": @(BackgroundImagePositionRightTop),
                                                                           @"right center": @(BackgroundImagePositionRight),
                                                                           @"right bottom": @(BackgroundImagePositionRightBottom),
                                                                           @"center bottom": @(BackgroundImagePositionBottom),
                                                                           @"left bottom": @(BackgroundImagePositionLeftBottom),
                                                                           @"left center": @(BackgroundImagePositionLeft)
                                                                           } defaultValue:BackgroundImagePositionCenter reverseDefaultValue:@"center center"];
}

+ (NSValueTransformer *)backgroundSizeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"contain": @(BackgroundImageSizeFit),
                                                                           @"cover": @(BackgroundImageSizeFill)
                                                                           } defaultValue:BackgroundImageSizeFit reverseDefaultValue:@"contain"];
}

+ (NSValueTransformer *)backgroundRepeatJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"no-repeat": @(BackgroundImageRepeatNoRepeat),
                                                                           @"repeat-x": @(BackgroundImageRepeatRepeatX),
                                                                           @"repeat-y": @(BackgroundImageRepeatRepeatY),
                                                                           @"repeat": @(BackgroundImageRepeatRepeat)
                                                                           } defaultValue:BackgroundImageRepeatNoRepeat reverseDefaultValue:@"no-repeat"];
}

+ (NSValueTransformer *)colorJSONTransformer {
    return [[ColorTransformer alloc] init];
}

+ (NSValueTransformer *)backgroundColorJSONTransformer {
    return [[ColorTransformer alloc] init];
}

+ (NSValueTransformer *)borderColorJSONTransformer {
    return [[ColorTransformer alloc] init];
}

@end

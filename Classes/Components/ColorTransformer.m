//
//  ColorTransformer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 06/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "ColorTransformer.h"
#import <UIKit/UIKit.h>
#import <HexColors/HexColor.h>

@implementation ColorTransformer

+ (Class)transformedValueClass {
    return [UIColor class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {

    if ([value isKindOfClass:[NSString class]]) {
        NSString *colorString = (NSString *)value;
        UIColor *color = [UIColor colorWithHexString:colorString];
        return color;
    }
    
    return nil;
}

@end

//
//  IconComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "IconComponentRenderer.h"
#import <FontAwesome+iOS/NSString+FontAwesome.h>

@implementation IconComponentRenderer

+ (UILabel *)render:(IconComponentModel *)component fromLayout:(LayoutModel *)layout {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(layout.left, layout.top, layout.width, layout.height)];
    
    NSString *fontAwesomeIdentifier = [@"icon-" stringByAppendingString:component.icon];
    label.text = [NSString fontAwesomeIconStringForIconIdentifier:fontAwesomeIdentifier];
    
    label.numberOfLines = 0;
    label.clipsToBounds = YES;
    
    if (component.style.textAlign) {
        label.textAlignment = component.style.textAlign;
    }
    
    if (component.style.fontSize) {
        label.font = [UIFont fontWithName:kFontAwesomeFamilyName size:component.style.fontSize.floatValue];
    } else {
        label.font = [UIFont fontWithName:kFontAwesomeFamilyName size:14];
    }
    
    if (component.style.color) {
        label.textColor = component.style.color;
    }
    
    return label;
}

@end

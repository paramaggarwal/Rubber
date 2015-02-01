//
//  TextComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "TextComponentRenderer.h"

@implementation TextComponentRenderer

+ (UILabel *)render:(TextComponentModel *)component {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(component.style.left.floatValue, component.style.top.floatValue, component.style.width.floatValue, component.style.height.floatValue)];
    label.numberOfLines = 0;
    label.clipsToBounds = YES;
    
    [self updateComponent:label withModel:component];
    
    return label;
}

+ (UILabel *)updateComponent:(UIView *)view withModel:(ComponentModel *)componentModel {
    
    TextComponentModel *component = (TextComponentModel *)componentModel;
    UILabel *label = (UILabel *)view;
    
    if (component.value) {
        label.text = component.value;
    }

    if (component.style.textAlign) {
        label.textAlignment = component.style.textAlign;
    }
    
    if (component.style.color) {
        label.textColor = component.style.color;
    }
    
    NSString *fontName = @"Arial";
    if (component.style.fontFamily) {
        fontName = component.style.fontFamily;
    }
    
    NSNumber *fontSize = [NSNumber numberWithFloat:14.0f];
    if (component.style.fontSize) {
        fontSize = component.style.fontSize;
    }
    
    label.font = [UIFont fontWithName:fontName size:fontSize.floatValue];
    
    return label;
    
}

@end


/*
 
 Supported font families
 
 AmaticSC-Bold
 AmaticSC-Regular
 Anton
 Audiowide-Regular
 Bangers-Regular
 Chewy
 Comfortaa-Bold
 Comfortaa-Light
 Comfortaa-Regular
 ComingSoon
 DancingScript-Bold
 DancingScript
 FrancoisOne-Regular
 IndieFlower
 Lobster-Regular
 MavenProBold
 MavenProRegular
 MavenProMedium
 MavenProBlack
 Orbitron-Black
 Orbitron-Bold
 Orbitron-Medium
 Orbitron-Regular
 Pacifico-Regular
 PermanentMarker
 Playball-Regular
 PoiretOne-Regular
 PTSans-Bold
 PTSans-BoldItalic
 PTSans-Italic
 PTSans-Regular
 Raleway-Thin
 Raleway-Light
 Raleway-ExtraBold
 Raleway-Bold
 Raleway
 Raleway-SemiBold
 Raleway-Heavy
 Raleway-Medium
 Raleway-ExtraLight
 Satisfy
 ShadowsIntoLight
 */

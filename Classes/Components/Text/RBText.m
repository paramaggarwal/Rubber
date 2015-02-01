//
//  TextComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "RBText.h"

@implementation RBText


+ (UILabel *)create:(RBTextModel *)model {
    
    RBText *label = [[UILabel alloc] initWithFrame:CGRectMake(model.style.left.floatValue,
                                                               model.style.top.floatValue,
                                                               model.style.width.floatValue,
                                                               model.style.height.floatValue)];
    label.numberOfLines = 0;
    label.clipsToBounds = YES;
    
    [label update:model];
    
    return label;
}

- (void)update:(RBTextModel *)model {
    
    if (model.value) {
        self.text = model.value;
    }

    if (model.style.textAlign) {
        self.textAlignment = model.style.textAlign;
    }
    
    if (model.style.color) {
        self.textColor = model.style.color;
    }
    
    NSString *fontName = @"Arial";
    if (model.style.fontFamily) {
        fontName = model.style.fontFamily;
    }
    
    NSNumber *fontSize = [NSNumber numberWithFloat:14.0f];
    if (model.style.fontSize) {
        fontSize = model.style.fontSize;
    }
    
    self.font = [UIFont fontWithName:fontName size:fontSize.floatValue];
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

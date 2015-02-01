//
//  StyleModel.h
//  LayoutTest
//
//  Created by Param Aggarwal on 06/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

typedef enum : NSUInteger {
    StyleFlexDirectionColumn,
    StyleFlexDirectionRow
} StyleFlexDirection;

typedef enum : NSUInteger {
    StyleJustifyContentFlexStart,
    StyleJustifyContentCenter,
    StyleJustifyContentFlexEnd,
    StyleJustifyContentSpaceBetween,
    StyleJustifyContentSpaceAround
} StyleJustifyContent;

typedef enum : NSUInteger {
    StyleFlexAlignStretch,
    StyleFlexAlignFlexStart,
    StyleFlexAlignCenter,
    StyleFlexAlignFlexEnd
} StyleFlexAlign;

typedef enum : NSUInteger {
    StylePositionRelative,
    StylePositionAbsolute
} StylePosition;

typedef enum : NSUInteger {
    BackgroundImageSizeFit,
    BackgroundImageSizeFill
} BackgroundImageSize;

typedef enum : NSUInteger {
    BackgroundImageRepeatNoRepeat,
    BackgroundImageRepeatRepeatX,
    BackgroundImageRepeatRepeatY,
    BackgroundImageRepeatRepeat,
} BackgroundImageRepeat;

typedef enum : NSUInteger {
    BackgroundImagePositionCenter,
    BackgroundImagePositionLeftTop,
    BackgroundImagePositionTop,
    BackgroundImagePositionRightTop,
    BackgroundImagePositionRight,
    BackgroundImagePositionRightBottom,
    BackgroundImagePositionBottom,
    BackgroundImagePositionLeftBottom,
    BackgroundImagePositionLeft
} BackgroundImagePosition;

@interface StyleModel : MTLModel <MTLJSONSerializing>

/* Layout */

@property (nonatomic, strong, readonly) NSNumber *left;
@property (nonatomic, strong, readonly) NSNumber *top;
@property (nonatomic, strong, readonly) NSNumber *right;
@property (nonatomic, strong, readonly) NSNumber *bottom;

@property (nonatomic, strong, readonly) NSNumber *width;
@property (nonatomic, strong, readonly) NSNumber *height;

@property (nonatomic, strong, readonly) NSNumber *marginLeft;
@property (nonatomic, strong, readonly) NSNumber *marginTop;
@property (nonatomic, strong, readonly) NSNumber *marginRight;
@property (nonatomic, strong, readonly) NSNumber *marginBottom;

@property (nonatomic, strong, readonly) NSNumber *paddingLeft;
@property (nonatomic, strong, readonly) NSNumber *paddingTop;
@property (nonatomic, strong, readonly) NSNumber *paddingRight;
@property (nonatomic, strong, readonly) NSNumber *paddingBottom;

@property (nonatomic, assign, readonly) StyleFlexDirection flexDirection;
@property (nonatomic, assign, readonly) StyleJustifyContent justifyContent;
@property (nonatomic, assign, readonly) StyleFlexAlign alignItems;
@property (nonatomic, assign, readonly) StyleFlexAlign alignSelf;

@property (nonatomic, strong, readonly) NSNumber *flex;
@property (nonatomic, assign, readonly) StylePosition position;

/* Border */

@property (nonatomic, strong, readonly) NSNumber *borderWidth;
@property (nonatomic, strong, readonly) NSNumber *borderRadius;
@property (nonatomic, strong, readonly) UIColor *borderColor;

/* Tile Styling */

@property (nonatomic, copy, readonly) NSString *backgroundImage;
@property (nonatomic, assign, readonly) BackgroundImagePosition backgroundPosition;
@property (nonatomic, assign, readonly) BackgroundImageRepeat backgroundRepeat;
@property (nonatomic, assign, readonly) BackgroundImageSize backgroundSize;
@property (nonatomic, strong, readonly) UIColor *backgroundColor;

/* Text Styling */

@property (nonatomic, strong, readonly) NSNumber *fontSize;
@property (nonatomic, strong, readonly) NSString *fontFamily;
@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, assign, readonly) NSTextAlignment textAlign;

@end

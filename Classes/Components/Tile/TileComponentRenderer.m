//
//  TileComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "TileComponentRenderer.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TileComponentRenderer

+ (UIView *)render:(TileComponentModel *)component {
    
    CGRect boundingBox = CGRectZero;
    for (TileComponentModel *child in component.children) {
        CGRect childBox = CGRectMake(child.style.left.floatValue, child.style.top.floatValue, child.style.width.floatValue, child.style.height.floatValue);
        boundingBox = CGRectUnion(boundingBox, childBox);
    }
    
    CGRect windowBox = CGRectMake(component.style.left.floatValue, component.style.top.floatValue, component.style.width.floatValue, component.style.height.floatValue);
    
    UIView *view;
    if ((boundingBox.size.height > windowBox.size.height) || (boundingBox.size.width > windowBox.size.width)) {
        // larger hence setup scrolling view
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:windowBox];
        scrollView.contentSize = boundingBox.size;
        scrollView.showsHorizontalScrollIndicator = YES;
        scrollView.showsVerticalScrollIndicator = YES;
        
        view = scrollView;
    } else {
        // everything fits, use normal view
        view = [[UIView alloc] initWithFrame:windowBox];
        view.clipsToBounds = YES;
    }
    
    [self updateComponent:view withModel:component];
    
    return view;
}

+ (UIView *)updateComponent:(UIView *)view withModel:(ComponentModel *)componentModel {
    
    TileComponentModel *component = (TileComponentModel *)componentModel;
    
    if (component.style.backgroundColor) {
        view.backgroundColor = component.style.backgroundColor;
    }
    
    if (component.style.borderColor) {
        view.layer.borderColor = component.style.borderColor.CGColor;
    }
    
    if (component.style.borderWidth) {
        view.layer.borderWidth = component.style.borderWidth.floatValue;
    }
    
    if (component.style.backgroundImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        NSString *url = component.style.backgroundImage;
        url = [url substringWithRange:NSMakeRange(4, url.length-1-4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        if (component.style.backgroundSize == BackgroundImageSizeFill) {
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        } else if (component.style.backgroundSize == BackgroundImageSizeFit) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [view insertSubview:imageView atIndex:0];
    }

    return view;
}

@end

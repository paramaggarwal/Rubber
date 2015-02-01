//
//  Renderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "ComponentRenderer.h"

#import "TileComponentRenderer.h"
#import "TextComponentRenderer.h"
#import "ImageComponentRenderer.h"
#import "IconComponentRenderer.h"
#import "SlideshowComponentRenderer.h"
#import "RBTableViewManager.h"

@implementation ComponentRenderer

+ (UIView *)updateComponent:(UIView *)view withModel:(ComponentModel *)model {
    
    if (model.style.left) {
        CGRect rect = view.frame;
        rect.origin.x = model.style.left.floatValue;
        view.frame = rect;
    }
    
    if (model.style.top) {
        CGRect rect = view.frame;
        rect.origin.y = model.style.top.floatValue;
        view.frame = rect;
    }
    
    if (model.style.width) {
        CGRect rect = view.frame;
        rect.size.width = model.style.width.floatValue;
        view.frame = rect;
    }
    
    if (model.style.height) {
        CGRect rect = view.frame;
        rect.size.height = model.style.height.floatValue;
        view.frame = rect;
    }
    
    if (model.style.backgroundColor) {
        view.backgroundColor = model.style.backgroundColor;
    }
    
    if (model.style.borderRadius) {
        view.layer.cornerRadius = model.style.borderRadius.floatValue;
    }
    
    if ([model.type isEqualToString:@"tile"]) {
        TileComponentModel *componentModel = (TileComponentModel *)model;
        [TileComponentRenderer updateComponent:view withModel:componentModel];
        
    } else if ([model.type isEqualToString:@"text"]) {
        TextComponentModel *componentModel = (TextComponentModel *)model;
        [TextComponentRenderer updateComponent:view withModel:componentModel];
    }
    
    return view;
}


+ (UIView *)renderComponent:(ComponentModel *)component {
    
    UIView *placeholderView;
    if ([component isKindOfClass:TileComponentModel.class]) {
        TileComponentModel *componentModel = (TileComponentModel *)component;
        placeholderView = [TileComponentRenderer render:componentModel];
        
    } else if ([component isKindOfClass:TextComponentModel.class]) {
        TextComponentModel *componentModel = (TextComponentModel *)component;
        placeholderView = [TextComponentRenderer render:componentModel];
        
    } else if ([component isKindOfClass:RBTableViewModel.class]) {
        RBTableViewModel *componentModel = (RBTableViewModel *)component;
        placeholderView = [RBTableViewManager create:componentModel];
        
    }
    
    if (component.style.backgroundColor) {
        placeholderView.backgroundColor = component.style.backgroundColor;
    }
    
    if (component.style.borderRadius) {
        placeholderView.layer.cornerRadius = component.style.borderRadius.floatValue;
    }
    
    return placeholderView;
}

@end

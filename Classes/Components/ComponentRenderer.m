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

@implementation ComponentRenderer

//+ (void)renderComponent:(ComponentModel *)component withLayout:(LayoutModel *)layout toView:(UIView *)view mainController:(UIViewController *)mainController {

//    UIView *placeholderView;
//    if ([component isKindOfClass:TileComponentModel.class]) {
//        TileComponentModel *componentModel = (TileComponentModel *)component;
//        placeholderView = [TileComponentRenderer render:componentModel fromLayout:layout];
//        
//    } else if ([component isKindOfClass:TextComponentModel.class]) {
//        TextComponentModel *componentModel = (TextComponentModel *)component;
//        placeholderView = [TextComponentRenderer render:componentModel fromLayout:layout];
//    
//    } else if ([component isKindOfClass:ImageComponentModel.class]) {
//        ImageComponentModel *componentModel = (ImageComponentModel *)component;
//        placeholderView = [ImageComponentRenderer render:componentModel fromLayout:layout];
//    
//    } else if ([component isKindOfClass:IconComponentModel.class]) {
//        IconComponentModel *componentModel = (IconComponentModel *)component;
//        placeholderView = [IconComponentRenderer render:componentModel fromLayout:layout];
//        
//    } else if ([component isKindOfClass:SlideshowComponentModel.class]) {
//        SlideshowComponentModel *componentModel = (SlideshowComponentModel *)component;
//        placeholderView = [SlideshowComponentRenderer render:componentModel fromLayout:layout mainController:mainController];
//    }
//    
//    // store a weak reference to rendered view on model
//    component.renderedView = placeholderView;
//    
//    if (component.href) {
//        UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:mainController action:@selector(handleTapGesture:)];
//        [placeholderView addGestureRecognizer:gestureRecogniser];
//        [placeholderView setUserInteractionEnabled:YES];
//    }
//    
//    if (component.style.backgroundColor) {
//        placeholderView.backgroundColor = component.style.backgroundColor;
//    }
//    
//    if (component.style.borderRadius) {
//        placeholderView.layer.cornerRadius = component.style.borderRadius.floatValue;
//    }
//
//    [view addSubview:placeholderView];
//    
//    if (layout.children.count > 0) {
//        for (int i = 0; i < layout.children.count; ++i) {
//            [self renderComponent:component.children[i] withLayout:layout.children[i] toView:placeholderView mainController:mainController];
//        }
//    }

//}

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
        
    }
    
    if (component.style.backgroundColor) {
        placeholderView.backgroundColor = component.style.backgroundColor;
    }
    
    if (component.style.borderRadius) {
        placeholderView.layer.cornerRadius = component.style.borderRadius.floatValue;
    }
    
    return placeholderView;
}

+ (ComponentModel *)searchView:(UIView *)view inModel:(ComponentModel *)model {
        
    if ([view isEqual:model.renderedView]) {
        return model;
    }
    
    for (ComponentModel *childModel in model.children) {
        ComponentModel *m = [self searchView:view inModel:childModel];
        if (m) {
            return m;
        }
    }
    
    return nil;
}

+ (NSString *)searchPath:(NSString *)searchPath forView:(UIView *)view inModel:(ComponentModel *)model {
   
    if ([view isEqual:model.renderedView]) {
        return searchPath;
    }
    
    for (int i=0; i<model.children.count; i++) {
        
        ComponentModel *childModel = [model.children objectAtIndex:i];
        NSString *childPath = [NSString stringWithFormat:@".%d", i];
        NSString *nextPath = [searchPath stringByAppendingString:childPath];
        
        NSString *foundPath = [self searchPath:nextPath forView:view inModel:childModel];
        if (foundPath) {
            return foundPath;
        }
    }
    
    return nil;
}


@end

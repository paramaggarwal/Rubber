//
//  ViewController.m
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "Rubber.h"
#import "CSSLayout.h"
#import "RBView.h"

@interface Rubber ()

// the changes to apply
@property RBViewModel *patchTree;

// primarily for references to the corresponding objects
@property RBViewModel *previousPatchTree;

@end

@implementation Rubber

- (void)applyPatch:(NSDictionary *)patchDictionary {
    self.previousPatchTree = self.patchTree;
    self.patchTree = [RBViewModel modelFromJSON:patchDictionary];
    [self applyPatch:self.patchTree previousPatch:self.previousPatchTree];
}

- (void)applyPatch:(RBViewModel *)tree previousPatch:(RBViewModel *)previousTree {
    
    tree.correspondingObject = previousTree.correspondingObject;
    
    if ([tree.action isEqualToString:@"update"]) {
        
        // depth first, so that parent has access to rendered children
        for (int i=0; i < tree.children.count; i++) {
            RBViewModel *child = [tree.children objectAtIndex:i];
            RBViewModel *previousChild = [previousTree.children objectAtIndex:i];
            
            [self applyPatch:child previousPatch:previousChild];
        }

        RBView *renderedView = (RBView *)tree.correspondingObject;
        [renderedView update:tree];
        
    } else if ([tree.action isEqualToString:@"add"]) {
        UIView *newView = [self createComponent:tree];
        // newView is set to model.correspondingObject by createComponent:
        
    } else if ([tree.action isEqualToString:@"remove"]) {
        // will be handled by the parent internally
        // [tree.correspondingObject removeFromSuperview];
        
    } else if ([tree.action isEqualToString:@"replace"]) {
        // removal will be handled by the parent internally
        // [tree.correspondingObject removeFromSuperview];
        [self createComponent:tree];
    }
    
}

- (RBView *)createComponent:(RBViewModel *)model {
    
    // depth first, so that parent has access to rendered children
    for (RBViewModel *child in model.children) {
        UIView *childView = [self createComponent:child];
    }

    RBView *view = [RBView create:model];
    model.correspondingObject = view;
    
    if (model.needsClickHandler) {
        UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [view addGestureRecognizer:gestureRecogniser];
        [view setUserInteractionEnabled:YES];
    }
    
    if (model.needsPanGesture) {
        UIPanGestureRecognizer *gestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [view addGestureRecognizer:gestureRecogniser];
        [view setUserInteractionEnabled:YES];
    }
    
    return view;
}

+ (NSDictionary *)computeLayout:(NSDictionary *)layoutDictionary {
    RBViewModel *model = [RBViewModel modelFromJSON:layoutDictionary];
    LayoutModel *layout = [CSSLayout computeLayout:model inRect:[[UIScreen mainScreen] bounds]];
    return [layout convertToDictionary];
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer {
    
    NSString *path = [self.patchTree searchPath:@"0" forView:recognizer.view];

    if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
        if ([self.gestureDelegate respondsToSelector:@selector(pathTapped:)]) {
            [self.gestureDelegate performSelector:@selector(pathTapped:) withObject:path];
        };
    } else if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        UIPanGestureRecognizer *gestureRecognizer = (UIPanGestureRecognizer *)recognizer;
        CGPoint translation = [gestureRecognizer translationInView:[recognizer.view superview]];
        
        if ([self.gestureDelegate respondsToSelector:@selector(pathPanned::)]) {
            [self.gestureDelegate performSelector:@selector(pathPanned::) withObject:path withObject:[NSValue valueWithCGPoint:translation]];
        };

        [gestureRecognizer setTranslation:CGPointZero inView:[recognizer.view superview]];
    }

    NSLog(@"Tapped %@", path);
}

@end

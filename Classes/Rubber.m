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
#import "RBScrollView.h"
#import "RBTableView.h"
#import "RBText.h"
#import "RBViewController.h"

@interface Rubber ()

// the changes to apply
@property RBViewModel *patchTree;

// primarily for references to the corresponding objects
@property RBViewModel *previousPatchTree;

@end

@implementation Rubber

- (id)applyPatch:(NSDictionary *)patchDictionary {
    self.previousPatchTree = self.patchTree;
    self.patchTree = [RBViewModel modelFromJSON:patchDictionary];
    [self applyPatch:self.patchTree previousPatch:self.previousPatchTree];
    return self.patchTree.correspondingObject;
}

- (void)applyPatch:(RBViewModel *)tree previousPatch:(RBViewModel *)previousTree {
    
    tree.correspondingObject = previousTree.correspondingObject;
    
    if ([tree.action isEqualToString:@"update"]) {
        
        // depth first, so that parent has access to rendered children
        for (int i=0; i < tree.children.count; i++) {
            
            RBViewModel *child = (i < tree.children.count) ? [tree.children objectAtIndex:i] : nil;
            RBViewModel *previousChild = (i < previousTree.children.count) ? [previousTree.children objectAtIndex:i] : nil;
            
            [self applyPatch:child previousPatch:previousChild];
        }

        [(RBView *)tree.correspondingObject update:tree];
        
    } else if ([tree.action isEqualToString:@"add"]) {
        tree.correspondingObject = [self createComponent:tree];
        
    } else if ([tree.action isEqualToString:@"remove"]) {
        // will be handled by the parent internally
        // tree.correspondingObject = nil;
        
    } else if ([tree.action isEqualToString:@"replace"]) {
        // removal will be handled by the parent internally
        // [tree.correspondingObject removeFromSuperview];
        tree.correspondingObject = [self createComponent:tree];
    }
    
}

- (id)createComponent:(RBViewModel *)model {
    
    // depth first, so that parent has access to rendered children
    for (RBViewModel *child in model.children) {
        child.correspondingObject = [self createComponent:child];
    }

    id correspondingObject;
    if ([model isKindOfClass:RBViewModel.class]) {
        correspondingObject = [RBView create:model];
    }
    
    if ([model isKindOfClass:RBScrollViewModel.class]) {
        correspondingObject = [RBScrollView create:model];
    }
    
    if ([model isKindOfClass:RBTableViewModel.class]) {
        correspondingObject = [RBTableView create:model];
    }
    
    if ([model isKindOfClass:RBTextModel.class]) {
        correspondingObject = [RBText create:model];
    }
    
    if ([model isKindOfClass:RBViewControllerModel.class]) {
        correspondingObject = [RBViewController create:model];
    }
    
    if ([correspondingObject isKindOfClass:UIView.class]) {
        UIView *view = (UIView *)correspondingObject;
        
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
    }
    
    
    return correspondingObject;
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

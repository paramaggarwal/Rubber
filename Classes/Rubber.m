//
//  ViewController.m
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "Rubber.h"
#import "CSSLayout.h"

#import "RBModel.h"
#import "RBView.h"
#import "RBScrollView.h"
#import "RBTableView.h"
#import "RBText.h"
#import "RBImage.h"
#import "RBViewController.h"
#import "RBNavigationController.h"

@interface Rubber ()

// the changes to apply
@property RBModel *patchTree;

// primarily for references to the corresponding objects
@property RBModel *previousPatchTree;

@end

@implementation Rubber

- (id)applyPatch:(NSDictionary *)patchDictionary {
    self.previousPatchTree = self.patchTree;
    self.patchTree = [RBModel modelFromJSON:patchDictionary];
    [self applyPatch:self.patchTree previousPatch:self.previousPatchTree];
    return self.patchTree.correspondingObject;
}

- (void)applyPatch:(RBModel *)tree previousPatch:(RBModel *)previousTree {
    
    tree.correspondingObject = previousTree.correspondingObject;
    
    if ([tree.action isEqualToString:@"update"]) {
        
        if ([tree isKindOfClass:RBViewControllerModel.class]) {
            [(RBViewController *)tree.correspondingObject update:(RBViewControllerModel *)tree];
        }

        // depth first, so that parent has access to rendered children
        for (int i=0; i < tree.children.count; i++) {
            
            RBModel *child = (i < tree.children.count) ? [tree.children objectAtIndex:i] : nil;
            RBModel *previousChild = (i < previousTree.children.count) ? [previousTree.children objectAtIndex:i] : nil;
            
            [self applyPatch:child previousPatch:previousChild];
        }

        if ([tree isKindOfClass:RBViewModel.class]) {
            [(RBView *)tree.correspondingObject update:(RBViewModel *)tree];
        }
        
        if ([tree isKindOfClass:RBScrollViewModel.class]) {
            [(RBScrollView *)tree.correspondingObject update:(RBScrollViewModel *)tree];
        }
        
        if ([tree isKindOfClass:RBTableViewModel.class]) {
            [(RBTableView *)tree.correspondingObject update:(RBTableViewModel *)tree];
        }
        
        if ([tree isKindOfClass:RBTextModel.class]) {
            [(RBText *)tree.correspondingObject update:(RBTextModel *)tree];
        }
        
        if ([tree isKindOfClass:RBImageModel.class]) {
            [(RBImage *)tree.correspondingObject update:(RBImageModel *)tree];
        }

        if ([tree isKindOfClass:RBViewControllerModel.class]) {
            [(RBViewController *)tree.correspondingObject updateChildren:(RBViewControllerModel *)tree];
        }
        
        if ([tree isKindOfClass:RBNavigationControllerModel.class]) {
            [(RBNavigationController *)tree.correspondingObject update:(RBNavigationControllerModel *)tree];
        }
        
    } else if ([tree.action isEqualToString:@"add"] || [tree.action isEqualToString:@"replace"]) {
        
        if ([tree isKindOfClass:RBViewControllerModel.class]) {
            tree.correspondingObject = [RBViewController create:(RBViewControllerModel *)tree];
        }
        
        // depth first, so that parent has access to rendered children
        for (RBModel *child in tree.children) {
            [self applyPatch:child previousPatch:nil];
        }
        
        if ([tree isKindOfClass:RBScrollViewModel.class]) {
            tree.correspondingObject = [RBScrollView create:(RBScrollViewModel *)tree];
        }
        
        if ([tree isKindOfClass:RBTableViewModel.class]) {
            tree.correspondingObject = [RBTableView create:(RBTableViewModel *)tree];
        }
        
        if ([tree isKindOfClass:RBTextModel.class]) {
            tree.correspondingObject = [RBText create:(RBTextModel *)tree];
        }
        
        if ([tree isKindOfClass:RBImageModel.class]) {
            tree.correspondingObject = [RBImage create:(RBImageModel *)tree];
        }
        
        if ([tree isKindOfClass:RBViewControllerModel.class]) {
            [(RBViewController *)tree.correspondingObject updateChildren:(RBViewControllerModel *)tree];
        }
        
        if ([tree isKindOfClass:RBNavigationControllerModel.class]) {
            tree.correspondingObject = [RBNavigationController create:(RBNavigationControllerModel *)tree];
        }
        
        if ([tree isKindOfClass:RBViewModel.class]) {
            tree.correspondingObject = [RBView create:(RBViewModel *)tree];
        }
        
        if ([tree.correspondingObject isKindOfClass:UIView.class]) {
            UIView *view = (UIView *)tree.correspondingObject;
            
            if (tree.needsClickHandler) {
                UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
                [view addGestureRecognizer:gestureRecogniser];
                [view setUserInteractionEnabled:YES];
            }
            
            if (tree.needsPanGesture) {
                UIPanGestureRecognizer *gestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
                [view addGestureRecognizer:gestureRecogniser];
                [view setUserInteractionEnabled:YES];
            }
            
        }
        
        if ([tree.correspondingObject isKindOfClass:RBViewController.class]) {
            RBViewController *viewController = (RBViewController *)tree.correspondingObject;
            RBViewControllerModel *viewControllerModel = (RBViewControllerModel *)tree;
            
            if (viewControllerModel.needsBackButton) {
                viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                                   initWithImage:[UIImage imageNamed:@"back-button-icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(backButtonTapped:)];
            }
            
        }
        
    } else if ([tree.action isEqualToString:@"remove"]) {
        // will be handled by the parent internally
        // tree.correspondingObject = nil;
        
    }
    
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

- (void)backButtonTapped:(UIBarButtonItem *)button {
    
//    NSString *path = [self.patchTree searchPath:@"0" forView:recognizer.view];
//    
//    if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
//        if ([self.gestureDelegate respondsToSelector:@selector(pathTapped:)]) {
//            [self.gestureDelegate performSelector:@selector(pathTapped:) withObject:path];
//        };
//    } else if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
//        UIPanGestureRecognizer *gestureRecognizer = (UIPanGestureRecognizer *)recognizer;
//        CGPoint translation = [gestureRecognizer translationInView:[recognizer.view superview]];
//        
//        if ([self.gestureDelegate respondsToSelector:@selector(pathPanned::)]) {
//            [self.gestureDelegate performSelector:@selector(pathPanned::) withObject:path withObject:[NSValue valueWithCGPoint:translation]];
//        };
//        
//        [gestureRecognizer setTranslation:CGPointZero inView:[recognizer.view superview]];
//    }
//    
//    NSLog(@"Tapped %@", path);
}

@end

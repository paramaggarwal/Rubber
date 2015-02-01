//
//  ViewController.m
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "Rubber.h"
#import "Fetcher.h"
#import "CSSLayout.h"
#import "ComponentRenderer.h"

// #import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface Rubber ()

@property ComponentModel *storedModel;
@property UIView *layoutView;

@property ComponentModel *patchModel;
@property ComponentModel *previousPatchModel;

@end

@implementation Rubber


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyPatch:(NSDictionary *)patchDictionary {
    self.previousPatchModel = self.patchModel;
    self.patchModel = [ComponentModel modelFromJSON:patchDictionary];
    
    [self applyPatch:self.patchModel toView:self.view previousPatch:self.previousPatchModel];
}

- (void)applyPatch:(ComponentModel *)model toView:(UIView *)view previousPatch:(ComponentModel *)previousModel {
    
    model.renderedView = previousModel.renderedView;
    
    if ([model.action isEqualToString:@"add"]) {
        UIView *newView = [self createComponent:model];
        [view addSubview:newView];
        
    } else if ([model.action isEqualToString:@"remove"]) {
        [model.renderedView removeFromSuperview];
        
    } else if ([model.action isEqualToString:@"update"]) {
        [self updateComponent:model.renderedView withModel:model withPreviousModel:previousModel];
    }
}

- (void)updateComponent:(UIView *)view withModel:(ComponentModel *)model withPreviousModel:(ComponentModel *)previousModel {
    
    UIView *updatedView =  [ComponentRenderer updateComponent:view withModel:model];
    
    for (int i=0; i<model.children.count; i++) {
        ComponentModel *child = [model.children objectAtIndex:i];
        ComponentModel *previousChild = [previousModel.children objectAtIndex:i];
        
        [self applyPatch:child toView:updatedView previousPatch:previousChild];
    }
}

- (UIView *)createComponent:(ComponentModel *)model {
    UIView *view = [ComponentRenderer renderComponent:model];
    model.renderedView = view;
    
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

    if (![model.type isEqualToString:@"TableView"]) {
        for (ComponentModel *child in model.children) {
            UIView *childView = [self createComponent:child];
            [view addSubview:childView];
        }
    }
    
    return view;
}

- (NSDictionary *)computeLayout:(NSDictionary *)layoutDictionary {
    ComponentModel *model = [ComponentModel modelFromJSON:layoutDictionary];
    
    LayoutModel *layout = [CSSLayout computeLayout:model inRect:self.view.bounds];
    return [layout convertToDictionary];
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer {
    
    NSString *path = [self.patchModel searchPath:@"0" forView:recognizer.view];

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

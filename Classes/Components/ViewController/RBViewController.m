//
//  RBViewController.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBViewController.h"
#import "CSSLayout.h"

@interface RBViewController ()

@end

@implementation RBViewController

+ (instancetype)create:(RBViewControllerModel *)model {
    
    RBViewController *controller = [[RBViewController alloc] init];
    [controller update:model];
    
    return controller;
}

- (void)update:(RBViewControllerModel *)model {
    
    LayoutModel *layoutTree = [CSSLayout computeLayout:model.fullObject inRect:self.view.bounds];
    [CSSLayout mergeLayoutTree:layoutTree intoModel:model];
    
    if (model.title) {
        self.title = model.title;
    }
}

- (void)updateChildren:(RBViewControllerModel *)model {
    
    for (RBModel *childModel in model.children) {
        UIView *childView = (UIView *)childModel.correspondingObject;
        
        if ([childModel.action isEqualToString:@"remove"]) {
            [childView removeFromSuperview];
        } else {
            [self.view addSubview:childView];
        }
    }
}

@end

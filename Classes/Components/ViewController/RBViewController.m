//
//  RBViewController.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBViewController.h"

@interface RBViewController ()

@end

@implementation RBViewController

+ (UIViewController *)create:(RBViewControllerModel *)model {
    
    RBViewController *controller = [[RBViewController alloc] init];
    [self parseChildren:model intoView:controller.view];

    [controller update:model];
    
    return controller;
}

- (void)update:(RBViewControllerModel *)model {
        
    if (model.title) {
        self.title = model.title;
    }
    
//    [self.class parseChildren:model intoView:self.view];
}

+ (void)parseChildren:(RBViewModel *)model intoView:(UIView *)view {
    
    for (RBViewModel *childModel in model.children) {
        id childObject = childModel.correspondingObject;
        
        if ([childObject isKindOfClass:UIView.class]) {
            UIView *childView = (UIView *)childObject;
            if ([childModel.action isEqualToString:@"remove"]) {
                [childView removeFromSuperview];
            } else if ([childModel.action isEqualToString:@"update"]) {
                if ([childView respondsToSelector:@selector(update:)]) {
                    [childView performSelector:@selector(update:) withObject:childModel];
                }
            } else {
                [view addSubview:childView];
            }
            
            [self parseChildren:childModel intoView:childView];
        }
    }
}

@end

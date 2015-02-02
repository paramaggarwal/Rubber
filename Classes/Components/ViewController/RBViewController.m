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
    [controller update:model];
    
    return controller;
}

- (void)update:(RBViewControllerModel *)model {
        
    if (model.title) {
        self.title = model.title;
    }

    // manage children
    for (RBViewModel *childModel in model.children) {
        UIView *childView = (UIView *)childModel.correspondingObject;
        
        if ([childModel.action isEqualToString:@"remove"]) {
            [childView removeFromSuperview];
        } else {
            [self.view addSubview:childView];
        }
    }
}

@end

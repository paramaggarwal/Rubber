//
//  NavigationController.m
//  Pods
//
//  Created by Param Aggarwal on 02/02/15.
//
//

#import "RBNavigationController.h"
#import "RBViewController.h"

@interface RBNavigationController ()

@end

@implementation RBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)create:(RBNavigationControllerModel *)model {
    
    RBViewControllerModel *rootControllerModel = model.children[0];
    RBViewController *rootController = (RBViewController *)rootControllerModel.correspondingObject;
    
    RBNavigationController *controller = [[RBNavigationController alloc] initWithRootViewController:rootController];
    [controller update:model];
    
    return controller;
}

- (void)update:(RBNavigationControllerModel *)model {
    
    RBViewControllerModel *firstControllerModel = (RBViewControllerModel *)[model.children firstObject];
    RBViewControllerModel *lastControllerModel = (RBViewControllerModel *)[model.children lastObject];
    
    if (![firstControllerModel isEqual:lastControllerModel]) {
        if ([lastControllerModel.action isEqualToString:@"remove"]) {
            [self popViewControllerAnimated:YES];
        } else if ([lastControllerModel.action isEqualToString:@"add"]) {
            RBViewController *controller = (RBViewController *)lastControllerModel.correspondingObject;
            [self pushViewController:controller animated:YES];
        }
    }
}

@end

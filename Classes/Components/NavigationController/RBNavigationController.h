//
//  NavigationController.h
//  Pods
//
//  Created by Param Aggarwal on 02/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBNavigationControllerModel.h"

@interface RBNavigationController : UINavigationController

+ (instancetype)create:(RBNavigationControllerModel *)model;
- (void)update:(RBNavigationControllerModel *)model;

@end

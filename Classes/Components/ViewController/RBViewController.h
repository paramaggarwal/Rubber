//
//  RBViewController.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBViewControllerModel.h"

@interface RBViewController : UIViewController

+ (instancetype)create:(RBViewControllerModel *)model;
- (void)update:(RBViewControllerModel *)model;
- (void)updateChildren:(RBViewControllerModel *)model;

@end

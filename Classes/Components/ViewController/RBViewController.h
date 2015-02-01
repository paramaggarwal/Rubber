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

+ (UIViewController *)create:(RBViewControllerModel *)model;
- (void)update:(RBViewControllerModel *)model;

@end

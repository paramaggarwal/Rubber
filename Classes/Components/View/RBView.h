//
//  RBView.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBViewModel.h"


@interface RBView : UIView

+ (instancetype)create:(RBViewModel *)model;
- (void)update:(RBViewModel *)model;

@end

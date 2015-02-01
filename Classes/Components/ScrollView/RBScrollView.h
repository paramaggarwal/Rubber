//
//  RBScrollView.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBScrollViewModel.h"

@interface RBScrollView : UIScrollView

+ (UIScrollView *)create:(RBScrollViewModel *)component;
- (void)update:(RBScrollViewModel *)model;

@end

//
//  RBView.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBViewModel.h"

@protocol RubberComponent <NSObject>

@required
+ (UIView *)create:(RBViewModel *)model;
- (void)update:(RBViewModel *)model;

@end


@interface RBView : UIView <RubberComponent>

+ (UIView *)create:(RBViewModel *)model;
- (void)update:(RBViewModel *)model;

@end

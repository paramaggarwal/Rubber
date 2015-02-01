//
//  Renderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ComponentModel.h"

@interface ComponentRenderer : NSObject

+ (UIView *)renderComponent:(ComponentModel *)component;
+ (UIView *)updateComponent:(UIView *)view withModel:(ComponentModel *)model;

@end

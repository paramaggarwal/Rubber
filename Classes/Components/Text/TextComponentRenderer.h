//
//  TextComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextComponentModel.h"

@interface TextComponentRenderer : NSObject

+ (UILabel *)updateComponent:(UIView *)view withModel:(ComponentModel *)componentModel;
+ (UILabel *)render:(TextComponentModel *)component;

@end

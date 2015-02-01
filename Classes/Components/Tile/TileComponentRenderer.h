//
//  TileComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileComponentModel.h"

@interface TileComponentRenderer : NSObject

+ (UIView *)render:(TileComponentModel *)component;
+ (UIView *)updateComponent:(UIView *)view withModel:(ComponentModel *)componentModel;

@end

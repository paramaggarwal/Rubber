//
//  CSSLayout.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentModel.h"
#import "LayoutModel.h"

@interface CSSLayout : NSObject

+ (LayoutModel *)computeLayout:(ComponentModel *)component inRect:(CGRect)rect;
+ (LayoutModel *)computeLayout:(ComponentModel *)component inRect:(CGRect)rect forceDimensions:(BOOL)force;

@end

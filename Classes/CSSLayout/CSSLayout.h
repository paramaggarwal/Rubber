//
//  CSSLayout.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBModel.h"
#import "LayoutModel.h"

@interface CSSLayout : NSObject

+ (LayoutModel *)computeLayout:(RBModel *)component inRect:(CGRect)rect;
+ (LayoutModel *)computeLayout:(RBModel *)component inRect:(CGRect)rect forceDimensions:(BOOL)force;

@end

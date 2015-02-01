//
//  IconComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconComponentModel.h"

@interface IconComponentRenderer : NSObject

+ (UILabel *)render:(IconComponentModel *)component fromLayout:(LayoutModel *)layout;

@end

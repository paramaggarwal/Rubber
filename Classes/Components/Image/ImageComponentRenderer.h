//
//  ImageComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageComponentModel.h"

@interface ImageComponentRenderer : NSObject

+ (UIImageView *)render:(ImageComponentModel *)component fromLayout:(LayoutModel *)layout;

@end

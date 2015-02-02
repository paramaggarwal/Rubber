//
//  ImageComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBImageModel.h"

@interface RBImage : UIImageView

+ (instancetype)create:(RBImageModel *)model;
- (void)update:(RBImageModel *)model;

@end

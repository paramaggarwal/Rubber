//
//  SlideshowComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideshowComponentModel.h"
#import "LayoutModel.h"

@interface SlideshowComponentRenderer : NSObject

+ (UIView *)render:(SlideshowComponentModel *)component fromLayout:(LayoutModel *)layout mainController:(UIViewController *)mainController;

@end

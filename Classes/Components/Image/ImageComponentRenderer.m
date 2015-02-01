//
//  ImageComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "ImageComponentRenderer.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ImageComponentRenderer

+ (UIImageView *)render:(ImageComponentModel *)component fromLayout:(LayoutModel *)layout {
    
    UIImageView *image = [[UIImageView  alloc] initWithFrame:CGRectMake(layout.left, layout.top, layout.width, layout.height)];
    image.clipsToBounds = YES;
    
    if (component.src) {
        [image sd_setImageWithURL:[NSURL URLWithString:component.src]];
    }
    
    return image;
}

@end

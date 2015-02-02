//
//  ImageComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "RBImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RBImage

+ (instancetype)create:(RBImageModel *)model {
    
    RBImage *image = [[RBImage  alloc] initWithFrame:model.layoutRect];
    image.clipsToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFit;

    [image update:model];
    
    return image;
}

- (void)update:(RBImageModel *)model {
    
    if (model.src) {
        [self sd_setImageWithURL:[NSURL URLWithString:model.src]];
    }
    
}


@end

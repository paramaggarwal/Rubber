//
//  RBView.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RBView

+ (UIView *)create:(RBViewModel *)model {
    
    CGRect windowBox = CGRectMake(model.style.left.floatValue,
                                  model.style.top.floatValue,
                                  model.style.width.floatValue,
                                  model.style.height.floatValue);
    
    RBView *view = [[RBView alloc] initWithFrame:windowBox];
    view.clipsToBounds = YES;

    [view update:model];
    
    return view;
}

- (void)update:(RBViewModel *)model {
    
    if (model.style.left || model.style.top || model.style.width || model.style.height) {
        CGRect rect = self.frame;
        
        if (model.style.left) {
            rect.origin.x = model.style.left.floatValue;
        }
        
        if (model.style.top) {
            rect.origin.y = model.style.top.floatValue;
        }
        
        if (model.style.width) {
            rect.size.width = model.style.width.floatValue;
        }
        
        if (model.style.height) {
            rect.size.height = model.style.height.floatValue;
        }
        
        self.frame = rect;
    }
    
    
    if (model.style.backgroundColor) {
        self.backgroundColor = model.style.backgroundColor;
    }
    
    if (model.style.borderColor) {
        self.layer.borderColor = model.style.borderColor.CGColor;
    }
    
    if (model.style.borderWidth) {
        self.layer.borderWidth = model.style.borderWidth.floatValue;
    }
    
    if (model.style.borderRadius) {
        self.layer.cornerRadius = model.style.borderRadius.floatValue;
    }

    if (model.style.backgroundImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        NSString *url = model.style.backgroundImage;
        url = [url substringWithRange:NSMakeRange(4, url.length-1-4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        if (model.style.backgroundSize == BackgroundImageSizeFill) {
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        } else if (model.style.backgroundSize == BackgroundImageSizeFit) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [self insertSubview:imageView atIndex:0];
    }
}

@end

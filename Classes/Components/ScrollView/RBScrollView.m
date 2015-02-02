//
//  RBScrollView.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RBScrollView

+ (UIScrollView *)create:(RBScrollViewModel *)model {
    
    CGRect boundingBox = CGRectZero;
    for (RBModel *child in model.children) {
        CGRect childBox = child.layoutRect;
        boundingBox = CGRectUnion(boundingBox, childBox);
    }
    
    RBScrollView *view = [[RBScrollView alloc] initWithFrame:model.layoutRect];
    view.contentSize = boundingBox.size;
    
    [view update:model];
    
    return view;
}

- (void)update:(RBModel *)model {
    
    if (!CGRectEqualToRect(self.frame, model.layoutRect)) {
        self.frame = model.layoutRect;
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
    
    // manage children
    for (RBModel *childModel in model.children) {
        UIView *childView = (UIView *)childModel.correspondingObject;
        
        if ([childModel.action isEqualToString:@"remove"]) {
            [childView removeFromSuperview];
        } else {
            [self addSubview:childView];
        }
    }
}

@end

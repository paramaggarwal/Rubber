//
//  SlideshowComponentRenderer.m
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "SlideshowComponentRenderer.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SlideshowCollectionView.h"
#import "SlideshowCollectionViewCell.h"
#import "LayoutModel.h"

@implementation SlideshowComponentRenderer

+ (UIView *)render:(SlideshowComponentModel *)component fromLayout:(LayoutModel *)layout mainController:(UIViewController *)mainController {
        
    CGRect windowBox = CGRectMake(layout.left, layout.top, layout.width, layout.height);
    
    SlideshowCollectionView *view = [[SlideshowCollectionView alloc] initWithFrame:windowBox collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [view registerClass:SlideshowCollectionViewCell.class forCellWithReuseIdentifier:@"view"];
    view.dataSource = view;
    view.delegate = view;
    view.mainController = mainController;
    view.modelData = component.children;
    view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)view.collectionViewLayout;
    flowLayout.itemSize = windowBox.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing = 0.0f;
    
    view.pagingEnabled = YES;
    
//    view.layer.borderWidth = 2.0f;
//    view.layer.borderColor = [UIColor redColor].CGColor;
    
    if (component.style.backgroundColor) {
        view.backgroundColor = component.style.backgroundColor;
    }
    
    if (component.style.borderColor) {
        view.layer.borderColor = component.style.borderColor.CGColor;
    }
    
    if (component.style.borderWidth) {
        view.layer.borderWidth = component.style.borderWidth.floatValue;
    }
    
    if (component.style.backgroundImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        NSString *url = component.style.backgroundImage;
        url = [url substringWithRange:NSMakeRange(4, url.length-1-4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        if (component.style.backgroundSize == BackgroundImageSizeFill) {
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        } else if (component.style.backgroundSize == BackgroundImageSizeFit) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [view insertSubview:imageView atIndex:0];
    }
    
    return view;
}

@end

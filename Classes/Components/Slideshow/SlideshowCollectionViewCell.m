//
//  SlideshowCollectionViewCell.m
//  LayoutTest
//
//  Created by Param Aggarwal on 13/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "SlideshowCollectionViewCell.h"
#import "CSSLayout.h"

@implementation SlideshowCollectionViewCell

- (void)renderView {
    LayoutModel *layout = [CSSLayout computeLayout:self.modelData inRect:self.contentView.bounds forceDimensions:YES];
    
    self.renderedView = [[UIView alloc] initWithFrame:self.contentView.bounds];
//    [ComponentRenderer renderComponent:self.modelData
//                            withLayout:layout
//                                toView:self.renderedView
//                        mainController:self.mainController];
    
    [self.contentView addSubview:self.renderedView];
}

- (void)prepareForReuse {
    [self.renderedView removeFromSuperview];
}

@end

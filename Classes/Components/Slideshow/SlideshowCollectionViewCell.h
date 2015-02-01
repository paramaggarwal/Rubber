//
//  SlideshowCollectionViewCell.h
//  LayoutTest
//
//  Created by Param Aggarwal on 13/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComponentRenderer.h"

@interface SlideshowCollectionViewCell : UICollectionViewCell

- (void)renderView;

@property ComponentModel *modelData;
@property UIView *renderedView;

@property UIViewController *mainController;

@end

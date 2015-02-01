//
//  SlideshowCollectionView.h
//  LayoutTest
//
//  Created by Param Aggarwal on 13/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideshowCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property NSArray *modelData;
@property UIViewController *mainController;

@end

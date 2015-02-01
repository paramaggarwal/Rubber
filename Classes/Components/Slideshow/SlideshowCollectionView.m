//
//  SlideshowCollectionView.m
//  LayoutTest
//
//  Created by Param Aggarwal on 13/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import "SlideshowCollectionView.h"
#import "RBView.h"
#import "SlideshowCollectionViewCell.h"

@implementation SlideshowCollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SlideshowCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"view" forIndexPath:indexPath];

//    cell.layer.borderWidth = 2.0f;
//    cell.layer.borderColor = [UIColor redColor].CGColor;
    
    RBViewModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    cell.modelData = modelData;
    cell.mainController = self.mainController;
    
    [cell renderView];
    
    return cell;
}

@end

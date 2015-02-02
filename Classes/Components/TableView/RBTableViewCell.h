//
//  RBTableViewCell.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBView.h"

@interface RBTableViewCell : UITableViewCell

- (void)renderView;

@property RBModel *modelData;
@property UIView *renderedView;

@end

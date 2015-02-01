//
//  RBTableViewCell.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "ComponentRenderer.h"

@interface RBTableViewCell : UITableViewCell

- (void)renderView;

@property ComponentModel *modelData;
@property UIView *renderedView;

@end

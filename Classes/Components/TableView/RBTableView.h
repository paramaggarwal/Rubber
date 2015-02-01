//
//  RBTableView.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>
#import "RBTableViewModel.h"

@interface RBTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property NSArray *modelData;

+ (instancetype)create:(RBTableViewModel *)model;
- (void)update:(RBTableViewModel *)model;

@end

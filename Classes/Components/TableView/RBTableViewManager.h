//
//  TableViewManager.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <Foundation/Foundation.h>
#import "RBTableViewModel.h"
#import "RBTableView.h"

@interface RBTableViewManager : NSObject

+ (void)update:(RBTableView *)tableView withModel:(RBTableViewModel *)model;
+ (RBTableView *)create:(RBTableViewModel *)model;

@end

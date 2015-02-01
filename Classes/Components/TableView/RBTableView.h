//
//  RBTableView.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import <UIKit/UIKit.h>

@interface RBTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property NSArray *modelData;

@end

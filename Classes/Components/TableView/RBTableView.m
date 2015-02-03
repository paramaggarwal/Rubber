//
//  RBTableView.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableView.h"
#import "RBTableViewCell.h"
#import "RBModel.h"

@implementation RBTableView

+ (instancetype)create:(RBTableViewModel *)model {
        
    RBTableView *tableView = [[RBTableView alloc] initWithFrame:model.layoutRect];
    [tableView registerClass:RBTableViewCell.class forCellReuseIdentifier:@"cell"];
    
    tableView.dataSource = tableView;
    tableView.delegate = tableView;
    tableView.rowHeight = 88.0f;
    
    [tableView update:model];
    
    return tableView;
}

- (void)update:(RBTableViewModel *)model {
    
    if (!CGRectEqualToRect(self.frame, model.layoutRect)) {
        self.frame = model.layoutRect;
    }

    if (model.style.backgroundColor) {
        self.backgroundColor = model.style.backgroundColor;
    }
    
    // manage children
    self.modelData = model.children;
//    [self beginUpdates];
//    for (int i=0; i < model.children.count; i++) {
//        RBModel *childModel = model.children[i];
//        
//        if ([childModel.action isEqualToString:@"update"]) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        } else if ([childModel.action isEqualToString:@"remove"]) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        } else {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
//    }
//    [self endUpdates];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RBModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    cell.model = modelData;
    [cell renderView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RBModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    return modelData.style.height.floatValue;
}

@end

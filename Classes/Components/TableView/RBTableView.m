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
    
    if (model.rowHeight != nil) {
        self.rowHeight = model.rowHeight.floatValue;
    }
    
    self.modelData = model.children;
    
    [self beginUpdates];
    for (int i=0; i < model.children.count; i++) {
        RBModel *childModel = model.children[i];
        
        if ([childModel.action isEqualToString:@"update"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else if ([childModel.action isEqualToString:@"remove"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        } else {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
    [self endUpdates];
    
//    [self reloadData];
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

@end

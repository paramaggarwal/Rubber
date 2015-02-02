//
//  RBTableView.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableView.h"
#import "RBTableViewCell.h"
#import "RBViewModel.h"

@implementation RBTableView

+ (instancetype)create:(RBTableViewModel *)model {
    
    CGRect windowBox = CGRectMake(model.style.left.floatValue,
                                  model.style.top.floatValue,
                                  model.style.width.floatValue,
                                  model.style.height.floatValue);
    
    RBTableView *tableView = [[RBTableView alloc] initWithFrame:windowBox];
    [tableView registerClass:RBTableViewCell.class forCellReuseIdentifier:@"cell"];
    
    tableView.dataSource = tableView;
    tableView.delegate = tableView;
    
    [tableView update:model];
    
    return tableView;
}

- (void)update:(RBTableViewModel *)model {
    
    if (model.style.left || model.style.top || model.style.width || model.style.height) {
        CGRect rect = self.frame;
        
        if (model.style.left) {
            rect.origin.x = model.style.left.floatValue;
        }
        
        if (model.style.top) {
            rect.origin.y = model.style.top.floatValue;
        }
        
        if (model.style.width) {
            rect.size.width = model.style.width.floatValue;
        }
        
        if (model.style.height) {
            rect.size.height = model.style.height.floatValue;
        }
        
        self.frame = rect;
    }
    
    
    if (model.style.backgroundColor) {
        self.backgroundColor = model.style.backgroundColor;
    }
    
    // manage children
    self.modelData = [model.children copy];
    [self beginUpdates];
    for (int i=0; i < model.children.count; i++) {
        RBViewModel *childModel = model.children[i];
        
        if ([childModel.action isEqualToString:@"update"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if ([childModel.action isEqualToString:@"remove"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    [self endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row <= self.modelData.count) {
        RBViewModel *modelData = [self.modelData objectAtIndex:indexPath.row];
        cell.modelData = modelData;
        [cell renderView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row <= self.modelData.count) {
        RBViewModel *modelData = [self.modelData objectAtIndex:indexPath.row];
        return modelData.style.height.floatValue;
    } else {
        return 44.0f;
    }
}

@end

//
//  TableViewManager.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableViewManager.h"
#import "RBTableViewCell.h"

@implementation RBTableViewManager

+ (void)update:(RBTableView *)tableView withModel:(RBTableViewModel *)model {
    
}

+ (RBTableView *)create:(RBTableViewModel *)model {
    
    CGRect windowBox = CGRectMake(model.style.left.floatValue, model.style.top.floatValue, model.style.width.floatValue, model.style.height.floatValue);
    
    RBTableView *tableView = [[RBTableView alloc] initWithFrame:windowBox];
    [tableView registerClass:RBTableViewCell.class forCellReuseIdentifier:@"cell"];
    
    tableView.dataSource = tableView;
    tableView.delegate = tableView;

    tableView.modelData = model.children;
    
//    tableView.layer.borderWidth = 1.0f;
//    tableView.layer.borderColor = [UIColor redColor].CGColor;
    
    return tableView;
}


@end

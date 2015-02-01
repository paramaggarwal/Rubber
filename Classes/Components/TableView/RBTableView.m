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

- (void)update:(RBTableViewModel *)model {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.layer.borderWidth = 2.0f;
//    cell.layer.borderColor = [UIColor redColor].CGColor;
    
    RBViewModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    cell.modelData = modelData;
    
    [cell renderView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RBViewModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    
    return modelData.style.height.floatValue;
}

@end

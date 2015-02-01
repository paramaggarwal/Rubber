//
//  RBTableView.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableView.h"
#import "RBTableViewCell.h"
#import "ComponentModel.h"

@implementation RBTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.layer.borderWidth = 2.0f;
//    cell.layer.borderColor = [UIColor redColor].CGColor;
    
    ComponentModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    cell.modelData = modelData;
    
    [cell renderView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ComponentModel *modelData = [self.modelData objectAtIndex:indexPath.row];
    
    return modelData.style.height.floatValue;
}

@end

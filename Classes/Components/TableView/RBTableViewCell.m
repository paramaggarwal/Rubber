//
//  RBTableViewCell.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBTableViewCell.h"

@implementation RBTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderView {
    
    UIView *view = (UIView *)self.model.correspondingObject;
    
    // reset frame origin
    CGRect frame = view.frame;
    frame.origin = CGPointZero;
    view.frame = frame;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    };
    [self.contentView addSubview:view];
//    self.contentView.clipsToBounds = YES;
    
//    // manage children
//    for (RBModel *childModel in self.model.children) {
//        UIView *childView = (UIView *)childModel.correspondingObject;
//        
//        if ([childModel.action isEqualToString:@"remove"]) {
//            if ([view.subviews indexOfObject:childModel] != NSNotFound) {
//                [childView removeFromSuperview];
//            }
//        } else {
//            if ([view.subviews indexOfObject:childModel] == NSNotFound) {
//                [view addSubview:childView];
//            }
//        }
//    }
}

- (void)prepareForReuse {
//    UIView *view = (UIView *)self.model.correspondingObject;

//    for (UIView *view in self.contentView.subviews) {
//        [view removeFromSuperview];
//    };
}

@end

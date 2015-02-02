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
    
    self.renderedView = (UIView *)self.modelData.correspondingObject;
    
    // reset frame origin
    CGRect frame = self.renderedView.frame;
    frame.origin = CGPointZero;
    self.renderedView.frame = frame;
    
    [self.contentView addSubview:self.renderedView];
    self.contentView.clipsToBounds = YES;
    
    // manage children
    for (RBModel *childModel in self.modelData.children) {
        UIView *childView = (UIView *)childModel.correspondingObject;
        
        if ([childModel.action isEqualToString:@"remove"]) {
            [childView removeFromSuperview];
        } else {
            [self.renderedView addSubview:childView];
        }
    }
}

- (void)prepareForReuse {
    [self.renderedView removeFromSuperview];
}

@end

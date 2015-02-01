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
    
    self.renderedView = [RBView create:self.modelData];
    
    // reset frame origin
    CGRect frame = self.renderedView.frame;
    frame.origin = CGPointZero;
    self.renderedView.frame = frame;
    
    [self.contentView addSubview:self.renderedView];
    self.contentView.clipsToBounds = YES;
}

- (void)prepareForReuse {
    [self.renderedView removeFromSuperview];
}

@end

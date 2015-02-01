//
//  TextComponentRenderer.h
//  LayoutTest
//
//  Created by Param Aggarwal on 08/01/15.
//  Copyright (c) 2015 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTextModel.h"

@interface RBText : UILabel

+ (UILabel *)create:(RBTextModel *)model;
- (void)update:(RBTextModel *)model;

@end

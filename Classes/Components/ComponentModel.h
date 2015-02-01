//
//  ComponentModel.h
//  LayoutTest
//
//  Created by Param Aggarwal on 06/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "StyleModel.h"
#import "LayoutModel.h"

@interface ComponentModel : MTLModel <MTLJSONSerializing>


@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *action;
@property (nonatomic, strong, readonly) NSArray *children;

// props.*
@property (nonatomic, strong, readonly) StyleModel *style;
@property (nonatomic, copy, readonly) NSString *href;
@property (nonatomic, assign, readonly) BOOL needsClickHandler;
@property (nonatomic, assign, readonly) BOOL needsPanGesture;

// helpers
@property (nonatomic, weak) UIView *renderedView;

@end

//
//  ViewController.h
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBView.h"

@interface Rubber : NSObject

@property RBViewModel *patchTree; // the changes to apply
@property RBViewModel *previousPatchTree; // primarily for references to the views

@property NSObject *gestureDelegate;

+ (NSDictionary *)computeLayout:(NSDictionary *)layoutDictionary;

- (void)applyPatch:(NSDictionary *)patchDictionary;

@end


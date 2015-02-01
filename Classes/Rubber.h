//
//  ViewController.h
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rubber : NSObject

@property NSObject *gestureDelegate;

+ (NSDictionary *)computeLayout:(NSDictionary *)layoutDictionary;

- (id)applyPatch:(NSDictionary *)patchDictionary;

@end


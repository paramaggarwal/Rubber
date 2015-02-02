//
//  RBViewControllerModel.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBModel.h"

@interface RBViewControllerModel : RBModel

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) BOOL needsBackButton;

@end

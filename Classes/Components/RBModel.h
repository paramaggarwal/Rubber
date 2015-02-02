//
//  RBViewModel.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "StyleModel.h"
#import "LayoutModel.h"

@interface RBModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *action;
@property (nonatomic, strong, readonly) NSArray *children;
@property (nonatomic, strong, readonly) RBModel *fullObject;

// props.*
@property (nonatomic, strong, readonly) StyleModel *style;
@property (nonatomic, assign, readonly) BOOL needsClickHandler;
@property (nonatomic, assign, readonly) BOOL needsPanGesture;

// helpers
@property (nonatomic, strong) NSObject *correspondingObject;
@property (nonatomic, assign) CGRect layoutRect;

+ (instancetype) modelFromJSON:(NSDictionary *)JSONDictionary;

- (instancetype)searchView:(UIView *)view;
- (NSString *)searchPath:(NSString *)searchPath forView:(UIView *)view;

@end

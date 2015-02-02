//
//  RBViewModel.h
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "StyleModel.h"

@interface RBViewModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *action;
@property (nonatomic, strong, readonly) NSArray *children;

// props.*
@property (nonatomic, strong, readonly) StyleModel *style;
@property (nonatomic, assign, readonly) BOOL needsClickHandler;
@property (nonatomic, assign, readonly) BOOL needsPanGesture;

// helpers
@property (nonatomic, strong) NSObject *correspondingObject;

+ (instancetype) modelFromJSON:(NSDictionary *)JSONDictionary;

- (instancetype)searchView:(UIView *)view;
- (NSString *)searchPath:(NSString *)searchPath forView:(UIView *)view;

@end

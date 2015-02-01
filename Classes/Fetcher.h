//
//  Fetcher.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBViewModel.h"

@interface Fetcher : NSObject

+ (RBViewModel *)fetch;
+ (void)fetchComponent:(NSString *)url
               success:(void (^)(RBViewModel *model))success
               failure:(void (^)(NSError *error))failure;

@end

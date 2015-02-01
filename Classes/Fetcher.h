//
//  Fetcher.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentModel.h"

@interface Fetcher : NSObject

+ (ComponentModel *)fetch;
+ (void)fetchComponent:(NSString *)url
               success:(void (^)(ComponentModel *model))success
               failure:(void (^)(NSError *error))failure;

@end

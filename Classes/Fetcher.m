//
//  Fetcher.m
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "Fetcher.h"
#import <Mantle/Mantle.h>
#import <AFNetworking/AFNetworking.h>

@implementation Fetcher

+ (RBViewModel *)fetch {
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"banner" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (!data) {
        NSLog(@"The file does not exist.");
        return nil;
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Unable to parse the JSON file.");
        return nil;
    }
    
    RBViewModel *component = [MTLJSONAdapter modelOfClass:RBViewModel.class fromJSONDictionary:dict error:&error];
    if (error) {
        NSLog(@"Unable to convert JSON to model.");
        return nil;
    }
    
    return component;
}

+ (void)fetchComponent:(NSString *)url success:(void (^)(RBViewModel *model))success failure:(void (^)(NSError *error))failure {

    [[AFHTTPRequestOperationManager manager] GET:url
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                          
                                             NSDictionary *dict = responseObject;

                                             NSError *error;
                                             RBViewModel *component = [MTLJSONAdapter modelOfClass:RBViewModel.class fromJSONDictionary:dict error:&error];
                                             if (error) {
                                                 return NSLog(@"Unable to convert JSON to model.");
                                             }
                                                                                          
                                             success(component);
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Error: %@", error);
                                         }];
}

@end

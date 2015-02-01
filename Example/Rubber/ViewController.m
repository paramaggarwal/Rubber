//
//  ViewController.m
//  Rubber
//
//  Created by Param Aggarwal on 30/01/15.
//  Copyright (c) 2015 Param. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Rubber/Rubber.h>
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@property JSContext *context;
@property UIView *renderedView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *jsFile = [path stringByAppendingPathComponent:@"main.js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
        
        // NSString *underscoreJsFile = [path stringByAppendingPathComponent:@"underscore-min.js"];
        // NSString *underscoreJsString = [NSString stringWithContentsOfFile:underscoreJsFile encoding:NSUTF8StringEncoding error:nil];

        JSVirtualMachine *machine = [[JSVirtualMachine alloc] init];
        JSContext *context = [[JSContext alloc] initWithVirtualMachine:machine];
        self.context = context;
    
        context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
            NSLog(@"JS Error: %@", exception);
        };
        
        Rubber *vc = [[Rubber alloc] init];
        vc.gestureDelegate = self;

        context[@"console"][@"log"] =  ^(JSValue *val) { NSLog(@"JSLog: %@", val); };
        
        context[@"request"] = @{};
        context[@"request"][@"get"] =  ^(NSString *url, JSValue *callback) {
            [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [callback callWithArguments:@[@NO, responseObject]];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [callback callWithArguments:@[error]];
            }];
        };
    
        // load underscore
        // [context evaluateScript:underscoreJsString];
        
        context[@"computeLayout"] = ^(NSDictionary *layoutDictionary) {
            return [vc computeLayout:layoutDictionary];
        };
        
        context[@"applyPatch"] = ^(NSDictionary *patchDictionary) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [vc applyPatch:patchDictionary];
            });
        };

        jsString = [@"var window = this;" stringByAppendingString:jsString];

        [context evaluateScript:jsString];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vc animated:YES];
        });

    });
}

- (void)pathTapped:(NSString *)path {
    JSValue *JSClickHandler = self.context[@"clickHandler"];
    [JSClickHandler callWithArguments:@[path]];
}

- (void)pathPanned:(NSString *)path :(NSValue *)pointValue {
    NSDictionary *pan = @{
                          @"x": [NSNumber numberWithFloat:pointValue.CGPointValue.x],
                          @"y": [NSNumber numberWithFloat:pointValue.CGPointValue.y]
                          };
    
    JSValue *JSClickHandler = self.context[@"panHandler"];
    [JSClickHandler callWithArguments:@[path, pan]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

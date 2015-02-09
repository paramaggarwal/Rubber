//
//  AppDelegate.m
//  Rubber
//
//  Created by Param Aggarwal on 01/02/15.
//  Copyright (c) 2015 Param. All rights reserved.
//

#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Rubber/Rubber.h>
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()

@property JSContext *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *jsFile = [path stringByAppendingPathComponent:@"main.js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
        
        JSVirtualMachine *machine = [[JSVirtualMachine alloc] init];
        JSContext *context = [[JSContext alloc] initWithVirtualMachine:machine];
        self.context = context;
        
        context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Javascript Exception"
                                                                     message:exception.toString
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                [alertView show];
            });
            NSLog(@"JS Error: %@", exception);
        };
        
        context[@"console"][@"log"] =  ^(JSValue *val) { NSLog(@"JSLog: %@", val); };
        
        context[@"request"] = @{};
        context[@"request"][@"get"] =  ^(NSString *url, JSValue *callback) {
            [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [callback callWithArguments:@[@NO, responseObject]];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [callback callWithArguments:@[error]];
            }];
        };
        
        Rubber *rubber = [[Rubber alloc] init];
        rubber.gestureDelegate = self;
        
        context[@"applyPatch"] = ^(NSDictionary *patchDictionary) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *rootController = [rubber applyPatch:patchDictionary];
                
                if (![self.window.rootViewController isEqual:rootController]) {
                    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                    self.window.backgroundColor = [UIColor whiteColor];
                    [self.window setRootViewController:rootController];
                    [self.window makeKeyAndVisible];
                }
            });
        };
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://local.myntra.com:3000/main.js"]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *script = [NSString stringWithUTF8String:[responseObject bytes]];
//            NSLog(@"%@", script);
            [context evaluateScript:script];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
            
    });

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


# pragma mark - gesture handling methods

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

- (void)backButtonTapped {
    JSValue *JSClickHandler = self.context[@"backButtonHandler"];
    [JSClickHandler callWithArguments:@[]];
}

@end

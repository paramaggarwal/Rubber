//
//  RBViewModel.m
//  Pods
//
//  Created by Param Aggarwal on 01/02/15.
//
//

#import "RBModel.h"

#import "RBViewModel.h"
#import "RBScrollViewModel.h"
#import "RBTableViewModel.h"
#import "RBTextModel.h"
#import "RBViewControllerModel.h"
#import "RBNavigationControllerModel.h"

#import "ImageComponentModel.h"
#import "IconComponentModel.h"
#import "SlideshowComponentModel.h"

@implementation RBModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"style": @"props.style",
             @"needsClickHandler": @"props.needsClickHandler",
             @"needsPanGesture": @"props.needsPanGesture",
             };
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if ([JSONDictionary[@"type"]  isEqual:@"View"]) {
        return RBViewModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"ScrollView"]) {
        return RBScrollViewModel.class;
    }

    if ([JSONDictionary[@"type"]  isEqual:@"TableView"]) {
        return RBTableViewModel.class;
    }

    if ([JSONDictionary[@"type"]  isEqual:@"Text"]) {
        return RBTextModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"ViewController"]) {
        return RBViewControllerModel.class;
    }

    if ([JSONDictionary[@"type"]  isEqual:@"NavigationController"]) {
        return RBNavigationControllerModel.class;
    }

    if ([JSONDictionary[@"type"]  isEqual:@"image"]) {
        return ImageComponentModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"icon"]) {
        return IconComponentModel.class;
    }
    
    if ([JSONDictionary[@"type"]  isEqual:@"slideshow"]) {
        return SlideshowComponentModel.class;
    }
    
    NSLog(@"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    
    return self;
}

+ (NSValueTransformer *) styleJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StyleModel class]];
}

+ (NSValueTransformer *) fullObjectJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[self class]];
}

+ (NSValueTransformer *) childrenJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[self class]];
}

- (instancetype)searchView:(UIView *)view {
    
    if ([view isEqual:self.correspondingObject]) {
        return self;
    }
    
    for (RBViewModel *childModel in self.children) {
        RBViewModel *m = [childModel searchView:view];
        if (m) {
            return m;
        }
    }
    
    return nil;
}

- (NSString *)searchPath:(NSString *)searchPath forView:(UIView *)view {
    
    if ([view isEqual:self.correspondingObject]) {
        return searchPath;
    }
    
    for (int i=0; i<self.children.count; i++) {
        
        RBViewModel *childModel = [self.children objectAtIndex:i];
        NSString *childPath = [NSString stringWithFormat:@".%d", i];
        NSString *nextPath = [searchPath stringByAppendingString:childPath];
        
        NSString *foundPath = [childModel searchPath:nextPath forView:view];
        if (foundPath) {
            return foundPath;
        }
    }
    
    return nil;
}

+ (instancetype)modelFromJSON:(NSDictionary *)JSONDictionary {
    NSError *error;
    RBViewModel *model = [MTLJSONAdapter modelOfClass:self.class
                                      fromJSONDictionary:JSONDictionary error:&error];
    if (error) {
        NSLog(@"Unable to convert JSON to model.");
        return nil;
    }
    
    return model;
}

@end

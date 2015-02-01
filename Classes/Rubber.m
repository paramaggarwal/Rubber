//
//  ViewController.m
//  Rubber
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "Rubber.h"
#import "Fetcher.h"
#import "CSSLayout.h"
#import "ComponentRenderer.h"

// #import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface Rubber ()

@property ComponentModel *storedModel;
@property UIView *layoutView;

@property ComponentModel *patchModel;
@property ComponentModel *previousPatchModel;

@end

@implementation Rubber


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_queue_t _backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    dispatch_async(_backgroundQueue, ^{
//        ASTextNode *node = [[ASTextNode alloc] init];
//        node.attributedString = [[NSAttributedString alloc] initWithString:@"hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello!"
//                                                                attributes:nil];
//        [node measure:CGSizeMake(160.0f, FLT_MAX)];
//        node.frame = (CGRect){ CGPointMake(100, 100), node.calculatedSize };
//        node.borderColor = [UIColor redColor].CGColor;
//        node.borderWidth = 1.0f;
//        
//        // self.view isn't a node, so we can only use it on the main thread
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            [self.view addSubview:node.view];
//        });
//    });
    
    
//    [self fetch];
    
//    [NSTimer scheduledTimerWithTimeInterval:5.0
//                                     target:self
//                                   selector:@selector(fetch)
//                                   userInfo:nil
//                                    repeats:YES];
    
    
//     List all the fonts loaded
//        for (NSString* family in [UIFont familyNames])
//        {
//            NSLog(@"%@", family);
//    
//            for (NSString* name in [UIFont fontNamesForFamilyName: family])
//            {
//                NSLog(@"  %@", name);
//            }
//        }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillLayoutSubviews {
//    [self renderCSSLayout];
//}

//- (void)fetchURL:(NSString *)url {
//    [Fetcher fetchComponent:url success:^(ComponentModel *model) {
//        
//        self.storedModel = model;
//        [self renderCSSLayout];
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"Error fetching: %@", error);
//    }];
//}

//- (void)renderLayout:(NSDictionary *)layoutDictionary {
//    
//    self.storedModel = [self convertToModel:layoutDictionary];
//    
//    [self renderCSSLayout];
//}

- (void)applyPatch:(NSDictionary *)patchDictionary {
    self.previousPatchModel = self.patchModel;
    self.patchModel = [self convertToModel:patchDictionary];
    
    [self applyPatch:self.patchModel toView:self.view previousPatch:self.previousPatchModel];
}

- (void)applyPatch:(ComponentModel *)model toView:(UIView *)view previousPatch:(ComponentModel *)previousModel {
    
    model.renderedView = previousModel.renderedView;
    
    if ([model.action isEqualToString:@"add"]) {
        UIView *newView = [self createComponent:model];
        [view addSubview:newView];
        
    } else if ([model.action isEqualToString:@"remove"]) {
        [model.renderedView removeFromSuperview];
        
    } else if ([model.action isEqualToString:@"update"]) {
        [self updateComponent:model.renderedView withModel:model withPreviousModel:previousModel];
    }
}

- (void)updateComponent:(UIView *)view withModel:(ComponentModel *)model withPreviousModel:(ComponentModel *)previousModel {
    
    UIView *updatedView =  [ComponentRenderer updateComponent:view withModel:model];
    
    for (int i=0; i<model.children.count; i++) {
        ComponentModel *child = [model.children objectAtIndex:i];
        ComponentModel *previousChild = [previousModel.children objectAtIndex:i];
        
        [self applyPatch:child toView:updatedView previousPatch:previousChild];
    }
}

- (UIView *)createComponent:(ComponentModel *)model {
    UIView *view = [ComponentRenderer renderComponent:model];
    model.renderedView = view;
    
    if (model.needsClickHandler) {
        UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [view addGestureRecognizer:gestureRecogniser];
        [view setUserInteractionEnabled:YES];
    }
    
    if (model.needsPanGesture) {
        UIPanGestureRecognizer *gestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [view addGestureRecognizer:gestureRecogniser];
        [view setUserInteractionEnabled:YES];
    }

    for (ComponentModel *child in model.children) {
        UIView *childView = [self createComponent:child];
        [view addSubview:childView];
    }
    
    return view;
}

//
//+ (UIView *)renderComponent:(NSDictionary *)component withChildren:childViews {
//
//    NSError *error;
//    ComponentModel *node = [MTLJSONAdapter modelOfClass:ComponentModel.class
//                                      fromJSONDictionary:component error:&error];
//    if (error) {
//        NSLog(@"Unable to convert JSON to ComponentModel.");
//        return nil;
//    }
//
//    LayoutModel *layout = [MTLJSONAdapter modelOfClass:LayoutModel.class
//                                      fromJSONDictionary:component[@"props"][@"style"] error:&error];
//    if (error) {
//        NSLog(@"Unable to convert JSON to LayoutModel.");
//        return nil;
//    }
//
//    UIView *view = [ComponentRenderer renderComponent:node withLayout:layout];
//    
//    for (UIView *v in childViews) {
//        [view addSubview:v];
//    }
//    
//    return view;
//    
//}

//- (void)renderCSSLayout {
//    if (self.storedModel) {
//        [self.layoutView removeFromSuperview];
//        
//        // initialize container scrollview
//        self.layoutView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        UIScrollView *containerView = (UIScrollView *)self.layoutView;
//
//        // attempt to accomodate navigation bar - must be cleaner way to do!!!
//        CGFloat offsetHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
//        containerView.contentOffset = CGPointMake(0, -offsetHeight);
//        containerView.contentInset = UIEdgeInsetsMake(offsetHeight, 0, 0, 0);
//
//        // compute layout
//        LayoutModel *layout = [CSSLayout computeLayout:self.storedModel inRect:self.view.bounds];
//        containerView.contentSize = CGSizeMake(layout.width, layout.height);
//
//        [ComponentRenderer renderComponent:self.storedModel withLayout:layout toView:self.layoutView mainController:self];
//        [self.view addSubview:self.layoutView];
//    }
//}

- (ComponentModel *)convertToModel:(NSDictionary *)componentDictionary {
    NSError *error;
    ComponentModel *model = [MTLJSONAdapter modelOfClass:ComponentModel.class
                                      fromJSONDictionary:componentDictionary error:&error];
    if (error) {
        NSLog(@"Unable to convert JSON to model.");
        return nil;
    }
    
    return model;
}

+ (NSDictionary *)convertToDictionary:(LayoutModel *)layout {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:layout.dictionaryValue];
    
    [layout.children enumerateObjectsUsingBlock:^(LayoutModel *m, NSUInteger index, BOOL *stop) {
        dict[@"children"][index] = [self convertToDictionary:m];
    }];
    
    return [dict copy];
}

- (NSDictionary *)computeLayout:(NSDictionary *)layoutDictionary {
    ComponentModel *model = [self convertToModel:layoutDictionary];
    LayoutModel *layout = [CSSLayout computeLayout:model inRect:self.view.bounds];
    return [self.class convertToDictionary:layout];
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer {
    
    // ComponentModel *model = [ComponentRenderer searchView:recognizer.view inModel:self.patchModel];
    NSString *path = [ComponentRenderer searchPath:@"0" forView:recognizer.view inModel:self.patchModel];

    if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
        if ([self.gestureDelegate respondsToSelector:@selector(pathTapped:)]) {
            [self.gestureDelegate performSelector:@selector(pathTapped:) withObject:path];
        };
    } else if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        UIPanGestureRecognizer *gestureRecognizer = (UIPanGestureRecognizer *)recognizer;
        CGPoint translation = [gestureRecognizer translationInView:[recognizer.view superview]];
        
        if ([self.gestureDelegate respondsToSelector:@selector(pathPanned::)]) {
            [self.gestureDelegate performSelector:@selector(pathPanned::) withObject:path withObject:[NSValue valueWithCGPoint:translation]];
        };

        [gestureRecognizer setTranslation:CGPointZero inView:[recognizer.view superview]];
    }

    NSLog(@"Tapped %@", path);
}

@end

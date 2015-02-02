//
//  CSSLayout.m
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "CSSLayout.h"
#import "Layout-utils.h"

@implementation CSSLayout

+ (LayoutModel *)computeLayout:(RBModel *)component inRect:(CGRect)rect forceDimensions:(BOOL)force {
    
    css_node_t *node = new_test_css_node();
    
    // wrap the layout tree inside the given rect
    bool isWrapped = NO;
    if (!CGRectIsEmpty(rect) && !force) {
        isWrapped = YES;
        node->style.position[CSS_LEFT] = rect.origin.x;
        node->style.position[CSS_RIGHT] = rect.origin.y;
        node->style.dimensions[CSS_WIDTH] = rect.size.width;
        node->style.dimensions[CSS_HEIGHT] = rect.size.height;
        init_css_node_children(node, 1);
        css_node_t *childNode = node->get_child(node->context, 0);
        [self configureCSSNodeTree:childNode fromComponent:component];
    } else if (force) {
        node->style.position[CSS_LEFT] = rect.origin.x;
        node->style.position[CSS_RIGHT] = rect.origin.y;
        node->style.dimensions[CSS_WIDTH] = rect.size.width;
        node->style.dimensions[CSS_HEIGHT] = rect.size.height;
        
        [self configureCSSNodeTree:node fromComponent:component];
    } else {
        [self configureCSSNodeTree:node fromComponent:component];
    }
    
    [self layoutNode:node];
    
    LayoutModel *layoutTree = [self toLayoutTree:node];
    
    if (isWrapped) {
        return [layoutTree.children objectAtIndex:0];
    } else {
        return layoutTree;
    }
}

+ (LayoutModel *)computeLayout:(RBModel *)component inRect:(CGRect)rect {
    return [self computeLayout:component inRect:rect forceDimensions:NO];
}

+ (LayoutModel *)toLayoutTree:(css_node_t *)node {
    
    LayoutModel *layout = [[LayoutModel alloc] init];

    layout.top = node->layout.position[CSS_TOP];
    layout.left = node->layout.position[CSS_LEFT];
    layout.width = node->layout.dimensions[CSS_WIDTH];
    layout.height = node->layout.dimensions[CSS_HEIGHT];
    
    if (node->children_count > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:node->children_count];
        for (int i = 0; i < node->children_count; ++i) {
            array[i] = [self toLayoutTree:node->get_child(node->context, i)];
        }
        layout.children = array;
    }
    
    return layout;
}

+ (css_node_t *)configureCSSNodeTree:(css_node_t *)node fromComponent:(RBModel *)component {
    
    [self configureCSSNode:node fromStyle:component.style];
    
    if (component.children.count > 0) {
        NSUInteger childrenCount = component.children.count;
        init_css_node_children(node, (int) childrenCount);
        
        for (int i = 0; i < childrenCount; ++i) {
            css_node_t *childNode = node->get_child(node->context, i);
            [self configureCSSNodeTree:childNode fromComponent:component.children[i]];
        }
    }
    
    return node;
}

+ (css_node_t *)configureCSSNode:(css_node_t *)node fromStyle:(StyleModel *)style {
    
    if (style.width) {
        node->style.dimensions[CSS_WIDTH] = style.width.floatValue;
    }
    
    if (style.height) {
        node->style.dimensions[CSS_HEIGHT] = style.height.floatValue;
    }

    if (style.left) {
        node->style.position[CSS_LEFT] = style.left.floatValue;
    }

    if (style.right) {
        node->style.position[CSS_RIGHT] = style.right.floatValue;
    }

    if (style.top) {
        node->style.position[CSS_TOP] = style.top.floatValue;
    }

    if (style.bottom) {
        node->style.position[CSS_BOTTOM] = style.bottom.floatValue;
    }

    if (style.marginLeft) {
        node->style.margin[CSS_LEFT] = style.marginLeft.floatValue;
    }

    if (style.marginRight) {
        node->style.margin[CSS_RIGHT] = style.marginRight.floatValue;
    }

    if (style.marginTop) {
        node->style.margin[CSS_TOP] = style.marginTop.floatValue;
    }

    if (style.marginBottom) {
        node->style.margin[CSS_BOTTOM] = style.marginBottom.floatValue;
    }

    if (style.paddingLeft) {
        node->style.padding[CSS_LEFT] = style.paddingLeft.floatValue;
    }
    
    if (style.paddingRight) {
        node->style.padding[CSS_RIGHT] = style.paddingRight.floatValue;
    }
    
    if (style.paddingTop) {
        node->style.padding[CSS_TOP] = style.paddingTop.floatValue;
    }
    
    if (style.paddingBottom) {
        node->style.padding[CSS_BOTTOM] = style.paddingBottom.floatValue;
    }
    
    if (style.flexDirection == StyleFlexDirectionColumn) {
        node->style.flex_direction = CSS_FLEX_DIRECTION_COLUMN;
    } else if (style.flexDirection == StyleFlexDirectionRow) {
        node->style.flex_direction = CSS_FLEX_DIRECTION_ROW;
    }
    
    if (style.justifyContent == StyleJustifyContentFlexStart) {
        node->style.justify_content = CSS_JUSTIFY_FLEX_START;
    } else if (style.justifyContent == StyleJustifyContentCenter) {
        node->style.justify_content = CSS_JUSTIFY_CENTER;
    } else if (style.justifyContent == StyleJustifyContentFlexEnd) {
        node->style.justify_content = CSS_JUSTIFY_FLEX_END;
    } else if (style.justifyContent == StyleJustifyContentSpaceBetween) {
        node->style.justify_content = CSS_JUSTIFY_SPACE_BETWEEN;
    } else if (style.justifyContent == StyleJustifyContentSpaceAround) {
        node->style.justify_content = CSS_JUSTIFY_SPACE_AROUND;
    }

    if (style.alignItems == StyleFlexAlignFlexStart) {
        node->style.align_items = CSS_ALIGN_FLEX_START;
    } else if (style.alignItems == StyleFlexAlignCenter) {
        node->style.align_items = CSS_ALIGN_CENTER;
    } else if (style.alignItems == StyleFlexAlignFlexEnd) {
        node->style.align_items = CSS_ALIGN_FLEX_END;
    } else if (style.alignItems == StyleFlexAlignStretch) {
        node->style.align_items = CSS_ALIGN_STRETCH;
    }
    
    if (style.alignSelf == StyleFlexAlignFlexStart) {
        node->style.align_self = CSS_ALIGN_FLEX_START;
    } else if (style.alignSelf == StyleFlexAlignCenter) {
        node->style.align_self = CSS_ALIGN_CENTER;
    } else if (style.alignSelf == StyleFlexAlignFlexEnd) {
        node->style.align_self = CSS_ALIGN_FLEX_END;
    } else if (style.alignSelf == StyleFlexAlignStretch) {
        node->style.align_self = CSS_ALIGN_STRETCH;
    }

    if (style.flex) {
        node->style.flex = style.flex.floatValue;
    }

    if (style.position == StylePositionRelative) {
        node->style.position_type = CSS_POSITION_RELATIVE;
    } else if (style.position == StylePositionAbsolute) {
        node->style.position_type = CSS_POSITION_ABSOLUTE;
    }
    
    return node;
}

+ (void)layoutNode:(css_node_t *)node {
    layoutNode(node, FLT_MAX);
    print_css_node(node, CSS_PRINT_LAYOUT | CSS_PRINT_CHILDREN);
}

@end

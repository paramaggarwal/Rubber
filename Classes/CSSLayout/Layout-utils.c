//
//  Layout-utils.c
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#include "Layout-utils.h"

static css_node_t* get_child(void *context, int i) {
    css_node_t* children = (css_node_t*)context;
    return &children[i];
}

static bool is_dirty(void *context) {
    (void)context; // remove unused warning
    return true;
}

static void init_test_css_node(css_node_t *node) {
    node->get_child = get_child;
    node->is_dirty = is_dirty;
}

css_node_t *new_test_css_node(void) {
    css_node_t *node = new_css_node();
    init_test_css_node(node);
    return node;
}

void init_css_node_children(css_node_t *node, int children_count) {
    node->context = calloc((size_t)children_count, sizeof(css_node_t));
    for (int i = 0; i < children_count; ++i) {
        init_css_node(node->get_child(node->context, i));
        init_test_css_node(node->get_child(node->context, i));
    }
    node->children_count = children_count;
}
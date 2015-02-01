//
//  Layout-utils.h
//  LayoutTest
//
//  Created by Param Aggarwal on 05/11/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#ifndef __LayoutTest__Layout_utils__
#define __LayoutTest__Layout_utils__

#include <stdio.h>

#endif /* defined(__LayoutTest__Layout_utils__) */

#include "Layout.h"

css_node_t *new_test_css_node(void);
static void init_test_css_node(css_node_t *node);

static bool is_dirty(void *context);

void init_css_node_children(css_node_t *node, int children_count);
static css_node_t* get_child(void *context, int i);

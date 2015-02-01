var _ = require('underscore'),
  React = require('react');

// incoming globals 
// computeLayout 
// applyPatch

// outgoing globals 
// clickHandler
// panHandler

var example1 = {
  before: {},
  after: {
    type: 'tile',
    props: {},
    children: [{
      type: 'text',
      props: {
        value: 'hello'
      },
      children: []
    }]
  }
};

var example2 = {
  before: {
    type: 'tile',
    props: {},
    children: [{
      type: 'text',
      props: {
        value: 'hello'
      },
      children: []
    }]
  },
  after: {
    type: 'tile',
    props: {},
    children: []
  }
};

var example3 = {
  before: {
    type: 'tile',
    props: {},
    children: [{
      type: 'text',
      props: {
        value: 'namaste'
      },
      children: []
    }]
  },
  after: {
    type: 'tile',
    props: {},
    children: [{
      type: 'text',
      props: {
        value: 'hello'
      },
      children: []
    }]
  }
};

function diff(oldTree, newTree) {
  var patch = {};

  if (!(oldTree && oldTree.type)) {
    patch.action = 'add';
    patch.type = newTree.type;
    patch.props = newTree.props;
    patch.children = newTree.children;
    return patch;
  } else if (!(newTree && newTree.type)) {
    patch.action = 'remove';
    patch.type = oldTree.type;
    return patch;
  } else if (oldTree.type === newTree.type) {
    patch.type = newTree.type;
    patch.action = 'update';
    patch.props = {};

    _.each(oldTree.props, function(val, key) {
      if (key === 'style') {
        patch.props.style = {};
        _.each(oldTree.props.style, function(val, key) {
          if (oldTree.props.style[key] !== newTree.props.style[key]) {
            patch.props.style[key] = newTree.props.style[key];
          }
        });
      } else {
        if (oldTree.props[key] !== newTree.props[key]) {
          patch.props[key] = newTree.props[key];
        }
      }
    });
  } else {
    patch.action = 'replace';
    patch.type = newTree.type;
    patch.props = newTree.props;
  }

  oldTree.children = oldTree.children || [];
  newTree.children = newTree.children || [];

  var longerArray = (oldTree.children.length >= newTree.children.length) ? oldTree.children : newTree.children;
  patch.children = _.map(longerArray, function(child, i) {
    return diff(oldTree.children[i], newTree.children[i]);
  });

  return patch;
}

var p1 = diff(example1.before, example1.after);
var p2 = diff(example2.before, example2.after);
var p3 = diff(example3.before, example3.after);

//console.log('Example1', p1);
//console.log('Example2', p2);
//console.log('Example3', p3);

var factorial = function(x) {

  console.log(x);

  if (x == 0) return 1;
  if (x == 1) return 1;

  return x * factorial(x - 1);
};

var previousRenderedTree;
var renderedTree = {};
var num1 = 0;
var num2 = 0;

var top1 = 300;
var left1 = 50;

var top2 = 500;
var left2 = 50;

var Cortex = {
  onClick1: function(e) {
    num1++;
  },

  onDrag1: function(x, y) {
    left1 += x;
    top1 += y;
  },

  onDrag2: function(x, y) {
    left2 += x;
    top2 += y;
  },

  onClick2: function(e) {
    num2++;
  },

  render: function() {

    return {
      type: 'tile',
      props: {
        style: {
          flex: 1,
          backgroundColor: '#EEEEEE',
          justifyContent: 'center',
          paddingBottom: 300
        }
      },
      children: [{
        type: 'text',
        props: {
          onClick: this.onClick1,
          needsClickHandler: true,
          onDrag: this.onDrag1,
          needsPanGesture: true,
          style: {
            backgroundColor: '#1D62F0',
            color: '#FFFFFF',
            borderRadius: 10,
            textAlign: 'center',
            height: 50,
            width: 200,
            top: top1,
            left: left1
          },
          value: num1 ? ('Tapped me ' + num1 + ((num1 == 1) ? ' time.' : ' times.')) : 'Hello there! Tap me...'
        },
        children: []
      }, {
        type: 'text',
        props: {
          onClick: this.onClick2,
          needsClickHandler: true,
          onDrag: this.onDrag2,
          needsPanGesture: true,
          style: {
            backgroundColor: '#F01D62',
            color: '#FFFFFF',
            borderRadius: 10,
            alignSelf: 'center',
            textAlign: 'center',
            height: 50,
            width: 200,
            top: top2,
            left: left2
          },
          value: num2 ? ('Tapped me ' + num2 + ((num2 == 1) ? ' time.' : ' times.')) : 'Hello there! Tap me...'
        },
        children: []
      }, {
        type: 'TableView',
        props: {
          style: {
            flex: 1,
            backgroundColor: '#FFFFFF',
            height: 400,
            top: 800
          }
        },
        children: [{
          type: 'text',
          props: {
            style: {
              color: '#F01D62',
              height: 44,
              width: 200
            },
            value: 'Small Cell One'
          },
          children: []
        }, {
          type: 'text',
          props: {
            style: {
              color: '#1D62F0',
              height: 88,
              width: 200
            },
            value: 'Large Cell Two'
          },
          children: []
        }]
      }]
    };
  }
}

function mergeNodes(original, overlap) {
  original.props.style.left = overlap.left;
  original.props.style.top = overlap.top;
  original.props.style.width = overlap.width;
  original.props.style.height = overlap.height;

  // console.log(JSON.stringify(original, null, 2));
  // console.log(JSON.stringify(overlap, null, 2));

  for (var i = 0; i < original.children.length; i++) {
    var childOriginal = original.children[i];
    var childOverlap = overlap.children[i];
    mergeNodes(childOriginal, childOverlap);
  }
};

function nodeAtPath(tree, path) {

  // remove first path as it is root
  if (path == [0]) {
    return tree;
  };
  path = path.slice(1);

  return _.reduce(path, function(node, index) {
    return node && node.children && node.children[index];
  }, tree);
}

function generatePatch() {
  var tree = Cortex.render();
  mergeNodes(tree, computeLayout(tree));

  previousRenderedTree = renderedTree;
  renderedTree = tree;

  var patch = diff(previousRenderedTree, renderedTree);
  // console.log(JSON.stringify(patch, null, 2));

  applyPatch(patch);

  return patch;
}


// request.get('http://developer.myntra.com/search/data/nike', function (err, res) {
//   console.log(err);
//   console.log(JSON.stringify(res, null, 2));
// });



function clickHandler(path) {
  console.log('Tapped path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onClick();

  generatePatch();
}

function panHandler(path, translation) {
  console.log('Panned path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onDrag(translation.x, translation.y);

  generatePatch();
}

global.clickHandler = clickHandler;
global.panHandler = panHandler;


generatePatch();
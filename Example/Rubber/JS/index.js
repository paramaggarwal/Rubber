/** @jsx tag */
var tag = require('./tag');

var _ = require('underscore');
var diff = require('./diff');

var Button1 = require('./Button1');
var Button2 = require('./Button2');
var CustomTableView = require('./CustomTableView');

var previousRenderedTree;
var renderedTree = {};

var Cortex = {
  render: function () {
    return (
      <ViewController title='Demo' style={{}}>
        <ScrollView style={{
          flex: 1,
          backgroundColor: '#EEEEEE',
          justifyContent: 'center',
          paddingBottom: 300
        }} >
          {Button1.render()}
          {Button2.render()}
          {CustomTableView.render()}
        </ScrollView>
      </ViewController>);
  }
};

function mergeNodes (original, overlap) {
  original.props.style.left = overlap.left;
  original.props.style.top = overlap.top;
  original.props.style.width = overlap.width;
  original.props.style.height = overlap.height;

  // console.log(JSON.stringify(original, null, 2));
  // console.log(JSON.stringify(overlap, null, 2));

  for (var i=0; i< original.children.length; i++) {
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

function generatePatch (tree) {
  if (!tree) {
    tree = Cortex.render();
  };

  mergeNodes(tree, computeLayout(tree));

  previousRenderedTree = renderedTree;
  renderedTree = tree;

  var patch = diff(previousRenderedTree, renderedTree);
  console.log(JSON.stringify(patch, null, 2));

  applyPatch(patch);

  return patch;
}

generatePatch();


request.get('http://developer.myntra.com/search/data/nike', function (err, res) {

  if (err) {
    console.log(err);
    return;
  }

  var products = res.data.results.products

  var productNames = _.pluck(products, 'product');

  var renderedChildren = _.map(productNames, function (name) {
    return {
        type: 'Text',
        props: {
          style: {
            color: '#1D62F0',
            height: 44,
            width: 300
          },
          value: name
        },
        children: []
      };
  });

  var tree = Cortex.render();
  tree.children[0].children[2].children = renderedChildren;

  // generatePatch(tree);

});

// setup globals
global.clickHandler = clickHandler;
global.panHandler = panHandler;






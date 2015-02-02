/** @jsx tag */
var tag = require('./tag');

var _ = require('underscore');
var diff = require('./diff');

var Button1 = require('./Button1');
var Button2 = require('./Button2');
var CustomTableView = require('./CustomTableView');

var products = [{
  product: 'Loading...' //just to make it show as a cell for now
}];

var previousRenderedTree;
var renderedTree = {};
var secondScreen;

var left = 0;
var top = 0;
var Button3 = {
  onClick: function (e) {
    showResults();
  },

  onDrag: function (x, y) {
    left += x;
    top += y;
  },

  render: function () {

    return (
      <Text onClick={this.onClick}
    needsClickHandler={true}
    onDrag={this.onDrag}
    needsPanGesture={true}
    style={{
      backgroundColor: '#1DD062',
      color: '#FFFFFF',
      borderRadius: 10,
      textAlign: 'center',
      height: 50,
      width: 200,
      top: top,
      left: left
    }}
    value={'See some Nike shoes'} />);
  }
};

var Cortex = {
  render: function () {
    if (secondScreen) {
      return (
        <NavigationController>
          <ViewController title='Demo' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {Button1.render()}
              {Button2.render()}
              {Button3.render()}
            </ScrollView>
          </ViewController>
          <ViewController title='Nike' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {CustomTableView.render({
                data: products
              })}
            </ScrollView>
          </ViewController>
        </NavigationController>
      );
    } else {
      return (
        <NavigationController>
          <ViewController title='Demo' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {Button1.render()}
              {Button2.render()}
              {Button3.render()}
            </ScrollView>
          </ViewController>
        </NavigationController>
      );
    }
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
  
  renderComponent(Cortex.render());
}

function panHandler(path, translation) {
  console.log('Panned path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onDrag(translation.x, translation.y);
  
  renderComponent(Cortex.render());
}

function renderComponent (tree) {
  previousRenderedTree = renderedTree;
  renderedTree = tree;

  var patch = diff(previousRenderedTree, renderedTree);
  console.log(JSON.stringify(patch, null, 2));

  applyPatch(patch);

  return patch;
}

// console.log(JSON.stringify(Cortex.render(), null, 2));

renderComponent(Cortex.render());


function showResults() {
  secondScreen = true;
  renderComponent(Cortex.render());

  request.get('http://developer.myntra.com/search/data/nike', function (err, res) {
    if (err) {
      console.log(err);
      return;
    }

    products = res.data.results.products;
    renderComponent(Cortex.render());
  });  
}

// setup globals
global.clickHandler = clickHandler;
global.panHandler = panHandler;






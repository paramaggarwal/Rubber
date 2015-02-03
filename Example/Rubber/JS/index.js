/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var _ = require('underscore');
var diff = require('./diff');

var Button1 = require('./Button1');
var Button2 = require('./Button2');
var Button3 = require('./Button3');
var SearchResultsView = require('./SearchResultsView');

var previousRenderedTree;
var renderedTree = {};

var Cortex = Rubber.createClass({
  getInitialState: function () {
    return {
      activeScreen: 'home',
      products: [{
        product: 'Loading...'
      }],
      styleid: null
    };
  },

  showSearch: function (products) {
    console.log('Now will show search results: ' + products.length);
    this.state.activeScreen = 'search';
    this.state.products = products;

    renderComponent(CortexApp.render());
  },

  showPDP: function (styleid) {
    console.log('Now will show PDP: ' + styleid);
    this.state.activeScreen = 'pdp';
    this.state.styleid = styleid;

    renderComponent(CortexApp.render());
  },

  render: function () {
    var self = this;

    if (this.state.activeScreen === 'search') {
      return (
        <NavigationController>
          <ViewController title='Demo' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {Button1().render()}
              {Button2().render()}
              {Button3().render({
                onLoadResults: self.showSearch
              })}
            </ScrollView>
          </ViewController>
          <ViewController title='Nike' needsBackButton={true} style={{}}>
              {SearchResultsView().render({
                data: self.state.products,
                onSelectRow: self.showPDP
              })}
          </ViewController>
        </NavigationController>
      );
    } else if (this.state.activeScreen === 'home') {
      return (
        <NavigationController>
          <ViewController title='Demo' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {Button1().render()}
              {Button2().render()}
              {Button3().render({
                onLoadResults: self.showSearch
              })}
            </ScrollView>
          </ViewController>
        </NavigationController>
      );
    } else if (this.state.activeScreen === 'pdp') {
      return (
        <NavigationController>
          <ViewController title='Demo' style={{}}>
            <ScrollView style={{
              flex: 1,
              backgroundColor: '#EEEEEE'
            }} >
              {Button1().render()}
              {Button2().render()}
              {Button3().render({
                onLoadResults: self.showSearch
              })}
            </ScrollView>
          </ViewController>
          <ViewController title='Nike' needsBackButton={true} style={{}}>
            {SearchResultsView().render({
              data: self.state.products,
              onSelectRow: self.showPDP
            })}
          </ViewController>
          <ViewController title='PDP' needsBackButton={true} style={{}}>
            <View style={{
            flex: 1,
            backgroundColor: '#EEEEEE'
          }} >
              <Text style={{flex: 1}} value={'PDP Page' + self.state.styleid}  />
            </View>
          </ViewController>
        </NavigationController>
      );
    } 
  }
});

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

global.clickHandler = function (path) {
  console.log('Tapped path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onClick();
  
  renderComponent(CortexApp.render());
}

global.panHandler = function (path, translation) {
  console.log('Panned path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onDrag(translation.x, translation.y);
  
  renderComponent(CortexApp.render());
}

function renderComponent (tree) {
  previousRenderedTree = renderedTree;
  renderedTree = tree;

  var patch = diff(previousRenderedTree, renderedTree);
  // console.log(JSON.stringify(patch, null, 2));

  applyPatch(patch);

  return patch;
}

var CortexApp = Cortex();

// console.log(JSON.stringify(CortexApp.render(), null, 2));

renderComponent(CortexApp.render());

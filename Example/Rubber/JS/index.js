/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var _ = require('underscore');
var diff = require('./diff');

var Button1 = require('./Button1');
var Button2 = require('./Button2');
var Button3 = require('./Button3');
var SearchResultsView = require('./SearchResultsView');
var PDPView = require('./PDPView');

var previousRenderedTree;
var renderedTree = {};

var Cortex = Rubber.createClass({
  getInitialState: function () {
    return {
      activeScreen: 'home',
      products: [{
        product: 'Loading...'
      }],
      styleid: null,
      pdpData: {}
    };
  },

  showSearch: function (products) {
    console.log('Now will show search results: ' + products.length);
    this.state.activeScreen = 'search';
    this.state.products = products;

    renderComponent(CortexApp.render());
  },

  showPDP: function (styleid, data) {
    console.log('Now will show PDP: ' + styleid);
    this.state.activeScreen = 'pdp';
    this.state.styleid = styleid;
    if (data) this.state.pdpData = data;

    renderComponent(CortexApp.render());
  },

  homeView: function() {
    var self = this;

    return (
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
    );
  },

  searchView: function () {
    var self = this;

    return (
      <ViewController title='Nike' needsBackButton={true} style={{}}>
        {SearchResultsView().render({
          data: self.state.products,
          onSelectRow: self.showPDP
        })}
      </ViewController>
    );
  },

  pdpView: function () {
    var self = this;

    return PDPView().render({
      data: self.state.pdpData
    });
  },

  render: function () {
    var self = this;
    var array = [];

    if (this.state.activeScreen === 'home') {
      array = [this.homeView()];
    };

    if (this.state.activeScreen === 'search') {
      array = [this.homeView(), this.searchView()];
    };

    if (this.state.activeScreen === 'pdp') {
      array = [this.homeView(), this.searchView(), this.pdpView()];
    };

    return (
      <NavigationController>
        {array}
      </NavigationController>
    );
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

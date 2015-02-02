/** @jsx tag */
var tag = require('./tag');
var _ = require('underscore');

var example1 = {
  before: {},
  after: <tile>
    <text value='hello'/>
  </tile>
};

var example2 = {
  before: <tile>
    <text value='hello'/>
  </tile>,
  after: <tile/>    
};

var example3 = {
  before:<tile>
    <text value='namaste'/>
  </tile>,
  after:<tile>
    <text value='hello'/>
  </tile>

};


function diff (oldTree, newTree) {
  var patch = {
    fullObject: newTree
  };

  oldTree = oldTree || {};
  newTree = newTree || {};

  if (!oldTree.type) {
    patch.action = 'add';
    patch.type = newTree.type;
    patch.props = newTree.props;

  } else if (!newTree.type) {
    patch.action = 'remove';
    patch.type = oldTree.type;
  
  } else if (oldTree.type === newTree.type) {
    patch.type = newTree.type;
    patch.action = 'update';
    patch.props = {};
    
    _.each(oldTree.props, function (val, key) {
      if (key === 'style') {
        patch.props.style = {};
        _.each(oldTree.props.style, function (val, key) {
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
  patch.children = _.map(longerArray, function (child, i) {
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

module.exports = diff;
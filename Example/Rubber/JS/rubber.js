var _ = require('underscore');

function createClass (spec) {

  var C = function() {

    if (!(this instanceof C)) {
      return new C();
    }

    var self = this;
    _.each(C.prototype, function(v, k){
      if (typeof self[k] === 'function') {
        self[k] = self[k].bind(self);
      }
    });

    if (self.getInitialState) {
      self.state = self.getInitialState();
    };
  };

  _.extend(C.prototype, spec);

  return C;
}

function createElement (name, props, children){
  var o; 
  if(Array.isArray(props)){
    children = props;
    props = {};
  }

  if (children && Array.isArray(children[0])) {
    children = children[0];
  };

  return {
    type: name,
    props: props || {},
    children: children || []
  }
}

var Rubber = {
  createClass: createClass,
  createElement: createElement
};

module.exports = Rubber;
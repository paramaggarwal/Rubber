var React = require('react');
var ReactMultiChild = require('react/lib/ReactMultiChild');
var ReactUpdates = require('react/lib/ReactUpdates');

var assign = require('react/lib/Object.assign');
var emptyObject = require('react/lib/emptyObject');

function createComponent(name){
	var NativeComponent = function(props){
		//ƒ

	}

	NativeComponent.displayName = name;

	return NativeComponent;
}
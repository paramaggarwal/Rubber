function tag(name, props, children){
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

module.exports = tag;
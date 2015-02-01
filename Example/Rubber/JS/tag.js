function tag(name, props, children){
	var o; 
	if(Array.isArray(props)){
		children = props;
		props = {};
	}

	return {
		type: name,
		props: props || {},
		children: children || []
	}
}

module.exports = tag;
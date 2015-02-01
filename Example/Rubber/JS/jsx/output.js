/** @jsx node */

var has = {}.hasOwnProperty;



function node(name, props, children){
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


////////////////// put The above at the top of your file.

// you can then write whatever jsx you want. 

console.log(node("something", {some:"prop", val:123}, [
	node("whatnot")
]));

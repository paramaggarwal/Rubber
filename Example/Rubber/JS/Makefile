bundle: 
	@echo "var window = this;" > main.js;
	@$$(npm bin)/browserify -t mercury-jsxify index.js >> main.js;

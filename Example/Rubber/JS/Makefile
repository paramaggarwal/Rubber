build: 
	@./node_modules/.bin/mercury-jsx index.js > index.cjs.js 
	@browserify index.cjs.js -o main.js
	@rm index.cjs.js
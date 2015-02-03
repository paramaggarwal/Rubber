/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var factorial = function (x) {

    console.log(x);
    
    if (x==0) return 1;
    if (x==1) return 1;
    
    return x * factorial(x-1);
};

module.exports = factorial;
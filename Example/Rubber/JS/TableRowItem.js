/** @jsx tag */
var tag = require('./tag');

var TableRowItem = {
  render: function(props) {
    var product = props.product;

    return <Text style={{
            color: '#1D62F0',
            height: 44,
            width: 300          
        }}
        value={product.product} />
  }
};

module.exports = TableRowItem;
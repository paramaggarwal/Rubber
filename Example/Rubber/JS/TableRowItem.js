/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var TableRowItem = Rubber.createClass({
  getInitialState: function() {
    return {
      name: '',
      key: null,
      didSelectRow: null
    }
  },

  onClick: function () {
    this.didSelectRow && this.didSelectRow(this.state.key);
  },

  render: function(props) {
    var product = props.product;
    var key = props.key;

    this.state.name = props.product.product;
    this.state.key = props.key;
    this.didSelectRow = props.didSelectRow;

    return (
      <View style={{height: 100, flexDirection: 'row'}} onClick={this.onClick} needsClickHandler={true} >
        <Image style={{
          flex: 1
        }}
        src={product.search_image} />
        <View style={{
          flex: 3
        }}>
          <Text style={{
            flex: 2,
            color: '#333333'
          }}
          value={product.product} />
          <Text style={{
            flex: 1,
            color: '#666666'
          }}
          value={product.discounted_price ? 'Rs. ' + product.discounted_price : ''} />
        </View>
      </View>
    );
  }
});

module.exports = TableRowItem;
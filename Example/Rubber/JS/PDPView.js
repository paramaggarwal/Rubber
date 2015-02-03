/** @jsx Rubber.createElement */

var Rubber = require('./rubber');
var _ = require('underscore');
var TableRowItem = require('./TableRowItem');

var SearchResultsView = Rubber.createClass({
  getInitialState: function () {
    return {
      products: []
    };
  },

  didSelectRow: function (index) {
    this.parentsOnSelectRow & this.parentsOnSelectRow(this.state.products[index].styleid);
  },

  render: function (props) {
    var products = props.data;

    this.state.products = props.data;
    this.parentsOnSelectRow = props.onSelectRow;

    var self = this;

    return <TableView style={{
            flex: 1,
            backgroundColor: '#FFFFFF'
          }} rowHeight={100} >
            {_.map(products, function(product, index) {
              return TableRowItem().render({
                product: product,
                key: index,
                didSelectRow: self.didSelectRow
              });
            })}
          </TableView>
  }
});

module.exports = SearchResultsView;
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
    var self = this;
    var styleid = this.state.products[index].styleid;
    self.parentsOnSelectRow & self.parentsOnSelectRow(styleid);

    request.get('http://developer.myntra.com/style/' + styleid, function (err, res) {
      if (err) {
        console.log(err);
        return;
      }

      self.parentsOnSelectRow & self.parentsOnSelectRow(styleid, res.data);
    });
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
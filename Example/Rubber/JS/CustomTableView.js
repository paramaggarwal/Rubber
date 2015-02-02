/** @jsx tag */
var tag = require('./tag');
var _ = require('underscore');
var TableRowItem = require('./TableRowItem');

var CustomTableView = {
  render: function(props) {
    var products = props.data;

    return <TableView style={{
            flex: 1,
            backgroundColor: '#FFFFFF'
          }}>
            {_.map(products, function(product) {
              return TableRowItem.render({
                product: product
              });
            })}
          </TableView>
  }
};

module.exports = CustomTableView;
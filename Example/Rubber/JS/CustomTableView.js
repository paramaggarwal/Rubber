/** @jsx tag */
var tag = require('./tag');

var CustomTableView = {
  render: function() {
    return <TableView style={{
            flex: 1,
            backgroundColor: '#FFFFFF',
            height: 400,
            top: 800
          }}>
            <Text style={{
              color: '#F01D62',
              height: 44,
              width: 200
            }}
            value='Small Cell One' />
            <Text style={{
              color: '#1D62F0',
              height: 88,
              width: 200
            }}
            value='Large Cell Two' />
          </TableView>
  }
};

module.exports = CustomTableView;
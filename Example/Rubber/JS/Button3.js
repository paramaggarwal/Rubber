/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var Button3 = Rubber.createClass({
  getInitialState: function () {
    return {
      top: 10,
      left: 10
    };
  },
  
  showResults: function () {
    var self = this;
    self.onLoadResults([{
      product: 'Loading...'
    }]);

    request.get('http://developer.myntra.com/search/data/nike-shoes', function (err, res) {
      if (err) {
        console.log(err);
        return;
      }

      self.onLoadResults(res.data.results.products);
    });  
  },

  onClick: function (e) {
    this.showResults();
  },

  onDrag: function (x, y) {
    this.state.left += x;
    this.state.top += y;
  },

  render: function (props) {
    this.onLoadResults = props.onLoadResults;

    return (
      <Text onClick={this.onClick}
    needsClickHandler={true}
    onDrag={this.onDrag}
    needsPanGesture={true}
    style={{
      backgroundColor: '#1DD062',
      color: '#FFFFFF',
      borderRadius: 10,
      textAlign: 'center',
      height: 50,
      width: 200,
      top: this.state.top,
      left: this.state.left
    }}
    value={'Search for Nike shoes'} />);
  }
});

module.exports = Button3;
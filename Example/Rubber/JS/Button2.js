/** @jsx Rubber.createElement */

var Rubber = require('./rubber');

var Button2 = Rubber.createClass({
  state: {
    num: 0,
    top: 200,
    left: 50
  },

  onClick: function (e) {
    this.state.num++;
  },

  onDrag: function (x, y) {
    this.state.left += x;
    this.state.top += y;
  },

  render: function () {

    return (
      <Text onClick={this.onClick}
    needsClickHandler={true}
    onDrag={this.onDrag}
    needsPanGesture={true}
    style={{
      backgroundColor: '#F01D62',
      color: '#FFFFFF',
      borderRadius: 10,
      textAlign: 'center',
      height: 50,
      width: 200,
      top: this.state.top,
      left: this.state.left
    }}
    value={this.state.num ? ('Tapped me ' + this.state.num + ((this.state.num==1) ? ' time.' : ' times.')) : 'Hello there! Tap me...'} />);
  }
});

module.exports = Button2;
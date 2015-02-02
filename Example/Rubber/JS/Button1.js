/** @jsx tag */
var tag = require('./tag');

var num = 0;
var top = 0;
var left = 50;

var Button1 = {
  onClick: function (e) {
    num++;
  },

  onDrag: function (x, y) {
    left += x;
    top += y;
  },

  render: function () {

    return <Text onClick={this.onClick}
    needsClickHandler={true}
    onDrag={this.onDrag}
    needsPanGesture={true}
    style={{
      backgroundColor: '#1D62F0',
      color: '#FFFFFF',
      borderRadius: 10,
      textAlign: 'center',
      height: 50,
      width: 200,
      top: top,
      left: left
    }}
    value={num ? ('Tapped me ' + num + ((num==1) ? ' time.' : ' times.')) : 'Hello there! Tap me...'} />
  }
};

module.exports = Button1;
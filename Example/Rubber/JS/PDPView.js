/** @jsx Rubber.createElement */

var Rubber = require('./rubber');
var _ = require('underscore');

var SearchResultsView = Rubber.createClass({
  getInitialState: function () {
    return {
      data: {}
    };
  },

  render: function (props) {
    var self = this;
    var pdpData = props.data || {};

    return (
      <ViewController title={pdpData.brandName || 'PDP'} needsBackButton={true} style={{}}>
        <ScrollView style={{
        flex: 1,
        backgroundColor: '#FFFFFF'
      }} >
        <View style={{height: 800}}>
          <Image style={{flex: 10}} src={pdpData.styleImages && pdpData.styleImages['default'].resolutions['360X480']} />
          <Text style={{flex: 1}} value={pdpData.productDisplayName || ''} />
          <Text style={{flex: 1}} value={pdpData.discountedPrice ? ('Rs. ' + pdpData.discountedPrice) : ''} />
          <Text style={{flex: 1}} value={pdpData.id ? ('Product Id: ' + pdpData.id) : ''} />
          <Text style={{flex: 1}} value={pdpData.productDisplayName || ''} />

          <Text style={{flex: 1}} value={'Product Description'} />
          <Text style={{flex: 6}} value={pdpData.productDescriptors ? pdpData.productDescriptors.description.value : ''} />
        </View>
        </ScrollView>
      </ViewController>
    );
  }
});

module.exports = SearchResultsView;
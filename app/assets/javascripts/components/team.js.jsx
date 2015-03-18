var Team = React.createClass({
  propTypes: {
    id: React.PropTypes.number,
    name: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Id: {this.props.id}</div>
        <div>Name: {this.props.name}</div>
      </div>
    );
  }
});

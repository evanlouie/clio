var UserTable = React.createClass({
  propTypes: {
    users: React.PropTypes.array
  },

  render: function() {
    return (
      <div>
        <div>Users: {this.props.users}</div>
      </div>
    );
  }
});

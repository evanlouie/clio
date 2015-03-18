var UserTableRow = React.createClass({
  propTypes: {
    user: React.PropTypes.instanceOf(User),
    team: React.PropTypes.instanceOf(Team)
  },

  render: function() {
    return (
      <div>
        <div>User: {this.props.user}</div>
        <div>Team: {this.props.team}</div>
      </div>
    );
  }
});

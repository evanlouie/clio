var User = React.createClass({
  propTypes: {
    id: React.PropTypes.number,
    firstName: React.PropTypes.string,
    lastName: React.PropTypes.string,
    status: React.PropTypes.string,
    website: React.PropTypes.string,
    email: React.PropTypes.string,
    team: React.PropTypes.instanceOf(Team)
  },

  render: function() {
    return (
      <div>
        <div>Id: {this.props.id}</div>
        <div>First Name: {this.props.first_name}</div>
        <div>Last Name: {this.props.last_name}</div>
        <div>Status: {this.props.status}</div>
        <div>Website: {this.props.website}</div>
        <div>Email: {this.props.email}</div>
        <Team id={this.props.team.id} name={this.props.team.name}/>
      </div>
    );
  }
});

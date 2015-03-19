@UsersTable = React.createClass
  getInitialState: ->
    { users: this.props.users }

  loadUsersFromServer: ->
    $.ajax
      url: @props.url
      data: @props.params
      dataType: 'json'
      success: ((data) ->
        this.setState users: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  componentDidMount: ->
    @loadUsersFromServer()
    setInterval(@loadUsersFromServer, @props.pollInterval)

  render: ->
    return `(
      <table id='users-table' className='table table-hover'>
        <thead>
          <tr>
            <th>Name</th>
            <th>Status</th>
            <th>Team</th>
          </tr>
        </thead>
        <UsersTableBody data={this.state.users} usersResource={this.props.usersResource} teamsResource={this.props.teamsResource}/>
      </table>
    )`


@UsersTableBody = React.createClass
  render: ->
    userNodes = @props.data.map(((user) ->
      return `(
        <UsersTableBodyRow key={user.id} data={user} usersResource={this.props.usersResource} teamsResource={this.props.teamsResource} />
      )`).bind(this))
    return `(
      <tbody>
        {userNodes}
      </tbody>
    )`

@UsersTableBodyRow = React.createClass
  render: ->
    name = @props.data.first_name+" "+@props.data.last_name
    user_href = @props.usersResource+"/"+@props.data.id
    if @props.data.team
      team_href = @props.teamsResource+"/"+@props.data.team.id
      team = `<a href={team_href}>{this.props.data.team.name}</a>`
    else
      team = "<No Team>"
    return `(
      <tr>
        <td><a href={user_href}>{name}</a></td>
        <td><UserStatusBadge data={this.props.data}/></td>
        <td>{team}</td>
      </tr>
    )`

@UserStatusBadge = React.createClass
  render: ->
    if this.props.data.status == 'in'
      statusClass = "status-badge label label-success label-as-badge"
    else
      statusClass = "status-badge label label-default label-as-badge"

    if this.props.data.status?
      status = this.props.data.status[0].toUpperCase()+this.props.data.status.slice(1)

    return `(
      <span className={statusClass}>{status}</span>
    )`

@CurrentUserInfo = React.createClass
  getInitialState: ->
    { data: this.props.data }
  loadUserFromServer: ->
    $.ajax
      url: @props.url
      data: @props.params
      dataType: 'json'
      success: ((data) ->
        this.setState data: data
        ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        ).bind(this)
  componentDidMount: ->
    @loadUserFromServer()
    setInterval(@loadUserFromServer, @props.pollInterval)

  render: ->
    name = this.state.data.first_name+" "+this.state.data.last_name
    mail_to = "mailto:"+this.state.data.email
    if @state.data.team
      team_url = this.props.teamsResource+'/'+this.state.data.team_id
      team = `<a href={team_url}>{this.state.data.team.name}</a>`
    else
      team = "<No Team>"
    return `(
      <table className="table table-condensed table-hover">
        <tbody>
          <tr><td><i className='fa fa-user'/></td><td><a href={this.props.url}>{name}</a></td></tr>
          <tr><td><i className='fa fa-check'/></td><td><UserStatusBadge data={this.state.data} /></td></tr>
          <tr><td><i className="fa fa-envelope"/></td><td><a href={mail_to}>{this.state.data.email}</a></td></tr>
          <tr><td><i className="fa fa-home"/></td><td><a href={this.state.data.web_site}>{this.state.data.web_site}</a></td></tr>
          <tr><td><i className="fa fa-users"/></td><td>{team}</td></tr>
        </tbody>
      </table>
    )`

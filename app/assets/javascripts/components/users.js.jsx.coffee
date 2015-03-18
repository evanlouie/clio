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
            <td>Name</td>
            <td>Status</td>
            <td>Team</td>
          </tr>
        </thead>
        <UsersTableBody data={this.state.users} />
      </table>
    )`


@UsersTableBody = React.createClass
  render: ->
    userNodes = @props.data.map((user) ->
      return `(
        <UsersTableBodyRow key={user.id} data={user} />
      )`)
    return `(
      <tbody>
        {userNodes}
      </tbody>
    )`

@UsersTableBodyRow = React.createClass
  render: ->
    name = @props.data.first_name+" "+@props.data.last_name
    return `(
      <tr>
        <td><span>{name}</span></td>
        <td><UserStatusBadge data={this.props.data}/></td>
        <td><span>{this.props.data.team.name}</span></td>
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
    team_url = "/teams/"+this.state.data.team_id
    return `(
      <div>
        <i className='fa fa-user'/> <a href={this.props.url}>{name}</a><br/>
        <i className='fa fa-check'/> <UserStatusBadge data={this.state.data} /><br/>
        <i className="fa fa-envelope"/> <a href="mailto:{this.state.data.email}">{this.state.data.email}</a><br/>
        <i className="fa fa-home"/> <a href={this.state.data.web_site}>{this.state.data.web_site}</a><br/>
        <i className="fa fa-users"/> <a href={team_url}>{this.state.data.team.name}</a><br/>
      </div>
    )`

@TeamsTable = React.createClass
  getInitialState: ->
    { teams: this.props.teams }

  loadTeamsFromServer: ->
    $.ajax
      url: @props.url
      data: @props.params
      dataType: 'json'
      success: ((data) ->
        this.setState teams: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  componentDidMount: ->
    @loadTeamsFromServer()
    # setInterval(@loadTeamsFromServer, @props.pollInterval)
    do refreshLoop = (->
      @loadTeamsFromServer()
      setTimeout(refreshLoop, @props.pollInterval)).bind(this)

  render: ->
    return `(
      <table id='teams-table' className='table table-hover'>
        <thead>
          <tr>
            <th>Name</th>
            <th>Members</th>
          </tr>
        </thead>
        <TeamsTableBody teams={this.state.teams} usersResource={this.props.usersResource} teamsResource={this.props.teamsResource} />
      </table>
    )`

@TeamsTableBody = React.createClass
  render: ->
    teamNodes = @props.teams.map(((team) ->
      return `(
        <TeamTableBodyRow key={team.id} team={team} usersResource={this.props.usersResource} teamsResource={this.props.teamsResource} />
      )`).bind(this))
    return `(
      <tbody>
       {teamNodes}
      </tbody>
    )`

@TeamTableBodyRow = React.createClass
  render: ->
    team_href = this.props.teamsResource+'/'+this.props.team.id
    team_edit_href = team_href+'/'
    return `(
      <tr>
        <td><a href={team_href}>{this.props.team.name}</a></td>
        <td><TeamTableBodyRowMemberList team={this.props.team} usersResource={this.props.usersResource} /></td>
      </tr>
    )`

@TeamTableBodyRowMemberList = React.createClass
  render: ->
    userLis = @props.team.users.map(((user) ->
      user_href = @props.usersResource+'/'+user.id
      user_name = user.first_name+' '+user.last_name
      return `(
        <li key={user.id}><a href={user_href}>{user_name} <UserStatusBadge data={user} /></a></li>
      )`).bind(this))
    return `(
      <ul>
        {userLis}
      </ul>
    )`

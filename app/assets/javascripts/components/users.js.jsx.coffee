@UserTable = React.createClass
  getInitialState: ->
    { data: [] }

  loadUsersFromServer: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      success: ((data) ->
        @setState data: data
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
      <table className="table table-hover table-striped table-bordered">
        <thead>
          <tr>
            <td>Name</td>
            <td>Status</td>
            <td>Team</td>
          </tr>
        </thead>
        <UserTableBody users={this.state.data} />
      </table>
    )`


@UserTableBody = React.createClass
  render: ->
    userNodes = @props.users.map((user) ->
      return `(
        <UserTableBodyRow user={user} />
      )`)
    return `(
      <tbody>
        {userNodes}
      </tbody>
    )`

@UserTableBodyRow = React.createClass
  render: ->
    if this.props.user.status == 'in'
      statusClass = "label label-success"
    else
      statusClass = "label label-warning"
    return `(
      <tr>
        <td><span>{this.props.user.full_name}</span></td>
        <td><span className={statusClass}>{this.props.user.status}</span></td>
        <td><a href="test">test</a></td>
      </tr>
    )`

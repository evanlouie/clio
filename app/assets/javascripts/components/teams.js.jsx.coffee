@Team = React.createClass
  getInitialState: ->
    { data: @props.data }

  loadTeamFromServer: ->
    $.ajax
      url: @props.url
      data: @props.params
      dataType: 'json'
      success: ((data) ->
        this.setState users: data
        return
      ).bind(this)
      error: ((xhr, status ,err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  componentDidMount: ->
    @loadTeamFromServer()
    setInterval(@loadTeamFromServer, @props.pollInterval)

  render: ->
    href = @props.teamsResource+'/'+@state.data.id
    return `(
      <a href={href}>{this.state.data.name}</a>
    )`

#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require react
#= require react_ujs
#= require components
#= require_tree .

$(document).ready ->
  $('.status-badge').each (index, el) ->
    React.render React.createElement(UserStatusBadge,
      url: $(el).prop('href')
      pollInterval: 3000
    ), $(el).parents('.status-container').get(0)
    return
  return

do pollStatus = ->
  $('.status-badge').each (index, value) ->
    console.log(index+": "+value)
    setTimeout pollStatus, 2000

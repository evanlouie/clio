#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require react
#= require react_ujs
#= require components
#= require_tree .



$(document).ready ->
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()


$(document).on 'change', '#current-user-control-form', ->
  form = this
  $.ajax
    url: $(form).prop('action')
    dataType: 'json'
    type: 'PUT'
    data: $(form).serialize()
    success: (data) ->
      return
    error: (xhr,status, err) ->
      console.log err
      return

@timeoutLoop = (fun, interval) ->
  setTimeout( (->
    fun()
    @timeoutLoop
    ), interval)
  return

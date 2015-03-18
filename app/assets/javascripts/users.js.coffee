$(document).on 'change', '#current-user-status-control', ->
  form = $(this).parents("form")
  data = form.serialize()
  el = this
  $(el).prop('disabled', true)
  $.post form.prop('action'), data, (data) ->
    $(el).prop('disabled', false)
  return

$(document).on 'input', '#user-search-input', ->
  form = $(this).parents('form')
  data = form.serialize()
  el = this
  $.ajax
    url: window.location.pathname
    data:
      query: $(el).val()
      page: 1
    success: (data) ->
      console.log($(data).find('#users').html())
      $("#users").html($(data).find('#users').html())
      # $("users-table").html(data)

    error: ((xhr, status, err) ->
      console.error @props.url, status, err.toString()
      return
    )

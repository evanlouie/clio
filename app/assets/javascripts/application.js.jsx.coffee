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

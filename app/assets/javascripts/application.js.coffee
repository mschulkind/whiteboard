#= require jquery
#= require jquery_ujs
#= require jquery.hammer
#= require underscore
#= require paper
#
#= require_tree .

$ ->
  $(document).on('touchstart', (e) -> e.preventDefault())
  $(document).on('touchmove', (e) -> e.preventDefault())

#= require jquery
#= require jquery_ujs
#= require jquery.hammer
#= require underscore
#= require paper
#= require private_pub
#= require uuid
#
#= require_tree .

$ ->
  $(document).on('touchstart', (e) -> e.preventDefault())
  $(document).on('touchmove', (e) -> e.preventDefault())

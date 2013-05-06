$ ->
  canvas = $('#canvas')

  resizeCanvas = ->
    canvas.css(
      width: $(window).width() - 10
      height: $(window).height() - 10
    )
  $(window).on('resize', resizeCanvas)
  resizeCanvas()
    
  $('#canvas').
    hammer().
    on(
      drag: (e) ->
        x = e.gesture.center.pageX - 6
        y = e.gesture.center.pageY - 6
        
        puts "#{x}, #{y}"
    )

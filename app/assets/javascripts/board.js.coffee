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
    
  paper.setup(canvas.get(0))
  path = new paper.Path
  path.strokeColor = 'black'

  path.add(new paper.Point(100, 100))
  path.add(new paper.Point(200, 200))
  paper.view.draw()

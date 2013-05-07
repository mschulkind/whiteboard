$ ->
  canvas = $('#canvas')

  resizeCanvas = ->
    canvas.css(
      width: $(window).width() - 10
      height: $(window).height() - 10
    )
  $(window).on('resize', resizeCanvas)
  resizeCanvas()
    
  paper.setup(canvas.get(0))
  path = null
  lineID = null
  queuedPoints = []
  requestInProgress = false

  queueRequest = ->
    sendingPoints = queuedPoints
    queuedPoints = []

    data =
      points: sendingPoints
      
    data.line_id = lineID if lineID
    
    requestInProgress = true
    $.ajax(
      type: 'POST'
      url: "/boards/#{window.boardID}/draw"
      data:
        data: JSON.stringify(data)
      
      success: (data) ->
        lineID = data.line_id
        
      error: ->
        alert 'error'
    ).done(->
      requestInProgress = false
      queueRequest() if queuedPoints.length
    )

  savePoint = (x, y) ->
    queuedPoints.push({x: x, y: y})
    queueRequest() unless requestInProgress
    
  startPath = ->
    path = new paper.Path
    path.strokeColor = 'red'
    
  addPoint = (x, y) ->
    path.add(new paper.Point(x, y))
    
  for line in window.initialData.lines
    startPath()

    for point in line.points
      addPoint(point.x, point.y)
      
    paper.view.draw()
  
  $('#canvas').
    hammer().
    on(
      dragstart: (e) ->
        lineID = null
        startPath()

      drag: (e) ->
        x = e.gesture.center.pageX - 6
        y = e.gesture.center.pageY - 6
        
        savePoint(x, y)
        addPoint(x, y)
        paper.view.draw()
    )
    


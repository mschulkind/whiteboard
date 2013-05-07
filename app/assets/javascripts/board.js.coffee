$ ->
  canvas = $('#canvas')
  paper.setup(canvas.get(0))
  
  resizeCanvas = ->
    width = $(window).width() - 10
    height = $(window).height() - 10

    paper.view.viewSize = [width, height]

    canvas.css(
      width: width
      height: height
    )

    paper.view.draw()

  $(window).on('resize', resizeCanvas)
  resizeCanvas()

  currentPath = null
  currentLineUUID = null
  queuedPoints = []
  requestInProgress = false
  
  lines = {}

  queueRequest = ->
    sendingPoints = queuedPoints
    queuedPoints = []

    data =
      points: sendingPoints
      line_uuid: currentLineUUID
    
    requestInProgress = true
    $.ajax(
      type: 'POST'
      url: "/boards/#{window.boardID}/draw"
      data:
        data: JSON.stringify(data)
      
      success: (data) ->
        
      error: ->
        alert 'error'
    ).done(->
      requestInProgress = false
      queueRequest() if queuedPoints.length
    )

  savePoint = (x, y) ->
    queuedPoints.push({x: x, y: y})
    _(-> queueRequest() unless requestInProgress).defer()
    
  createPath = ->
    path = new paper.Path
    path.strokeColor = 'red'
    path
    
  startPath = ->
    currentPath = createPath()
    currentLineUUID = window.uuid.v1()
    
  addPoint = (x, y) ->
    currentPath.add(new paper.Point(x, y))
    
  window.addPoints = (lineUUID, points) ->
    unless lines[lineUUID] == true
      path = lines[lineUUID] ||= createPath()
      
      for point in points
        path.add(new paper.Point(point.x, point.y))
        
      paper.view.draw()
    
  for line in window.initialData.lines
    startPath()

    for point in line.points
      addPoint(point.x, point.y)
      
    paper.view.draw()
  
  $('#canvas').
    hammer().
    on(
      dragstart: (e) ->
        startPath()
        lines[currentLineUUID] = true

      drag: (e) ->
        x = e.gesture.center.pageX - 6
        y = e.gesture.center.pageY - 6
        
        savePoint(x, y)
        addPoint(x, y)
        paper.view.draw()
    )
    


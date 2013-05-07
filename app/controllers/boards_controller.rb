class BoardsController < ApplicationController
  def create
    board = Board.create

    redirect_to "/boards/#{board.id}"
  end
  
  def show
    @board = Board.find(params[:id])
    
    raise ActionController::RoutingError.new('Not Found') unless @board
  end
  
  def draw
    board = Board.find(params[:id])
    
    data = ActiveSupport::JSON.decode(params[:data])

    line = 
      if line_id = data['line_id']
        board.lines.find(line_id)
      else
        board.lines.create
      end
    
    line.points.push(*data['points'].map do |point|
      Point.new(x: point['x'], y: point['y'])
    end)

    render json: {line_id: line.id}
  end
end

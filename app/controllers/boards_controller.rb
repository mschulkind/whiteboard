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
      board.lines.where(uuid: data['line_uuid']).first ||
      board.lines.create(uuid: data['line_uuid'])
    
    PrivatePub.publish_to(
      "/boards/#{params[:id]}",
      "window.addPoints('#{line.uuid}', #{data['points'].to_json})")
    
    line.points.push(*data['points'].map do |point|
      Point.new(x: point['x'], y: point['y'])
    end)

    render json: {}
  end
end

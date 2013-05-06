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
    
  end
end

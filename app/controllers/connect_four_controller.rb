class ConnectFourController < ApplicationController
  def game_result
    raise 'test me'
    moves = params[:moves].split(',')
    connect_four_game = ConnectFourGame.new(moves)
    render json: connect_four_game.game_result
  end

  def computer_move
    raise 'test me'
    moves = params[:moves].split(',')
    depth = params[:depth]
    connect_four_game = ConnectFourGame.new(moves)
    render json: connect_four_game.computer_move(depth)
  end
end

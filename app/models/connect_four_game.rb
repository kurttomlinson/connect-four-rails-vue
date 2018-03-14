class ConnectFourGame
  require "#{Rails.root}/lib/console-connect-four/connect_four_move_tree.rb"
  def initialize(moves)
    @game_tree = ConnectFourMoveTree.new
    @game_tree.load_game(moves)
  end
  def game_result
    @game_tree.winner || 'incomplete'
  end
  def computer_move(depth)
    @game_tree.ai_choose_column(depth)
  end
end

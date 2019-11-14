require 'test_helper'

class GameTest < MiniTest::Test
  def setup
    @game = Game.new
  end

  def test_horizontal_victory
    @game.drop_checker(0)
    @game.drop_checker(1)
    @game.drop_checker(2)
    @game.drop_checker(3)
    assert(@game.horizontal_victory?)
  end

  def test_vertical_victory
    @game.drop_checker(0) # black
    @game.drop_checker(1) # red
    @game.drop_checker(0) # black
    @game.drop_checker(1) # red
    @game.drop_checker(0) # black
    @game.drop_checker(1) # red
    @game.drop_checker(0) # black
    @game.swap_player
    assert(@game.vertical_victory?)
  end

  # def test_diagonal_victory
  #   @game.drop_checker(0)
  #   @game.drop_checker(0)
  #   @game.drop_checker(0)
  #   @game.drop_checker(0)
  #   assert(@game.diagonal_victory?)

  # end

end

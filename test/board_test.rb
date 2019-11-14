require 'test_helper'

class BoardTest < MiniTest::Test
  def setup
    @board = Board.new
  end

  def test_drop_first_checker_first_column
    @board.drop_checker(:black, 0)
    assert_equal(:black, @board.rows.last.first)
  end

  def test_drop_second_checker_first_column
    @board.drop_checker(:black, 0)
    @board.drop_checker(:red, 0)
    assert_equal(:black, @board.rows.last.first)
    assert_equal(:red, @board.rows[-2].first)
  end

  def test_drop_first_checker_second_column
    @board.drop_checker(:black, 1)
    assert_equal(:black, @board.rows.last[1])
  end

  def test_drop_two_checkers_two_columns
    @board.drop_checker(:black, 0)
    @board.drop_checker(:red, 1)
    assert_equal(:black, @board.rows.last[0])
    assert_equal(:red, @board.rows.last[1])
  end

end

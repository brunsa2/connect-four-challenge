# Use this as a sketch of how your Board class could look, you can fill in these
# methods, or make a different class from scratch
# require 'tty-table'
require_relative './column'
require_relative './color'
require 'byebug'

class Board
  def self.starting_with_red
    self.new(Color.new(:red))
  end

  def drop_checker(column)
    raise ArgumentError unless column.is_a?(Column)

    raise StandardError, "column full" if [6, 13, 20, 27, 34, 41, 48].include?(@next_positions[column.to_index])

    board = @boards[@next_color.to_sym]
    move = 1 << @next_positions[column.to_index]
    board_with_move = board | move

    Board.new(
      @next_color.opponent_color,
      {
        @next_color.to_sym => board_with_move,
        @next_color.opponent_color.to_sym => @boards[@next_color.opponent_color.to_sym]
      },
      next_position_after_move(column, @next_positions)
    )
  end

  def next_color
    @next_color
  end

  def any_valid_move?
    @next_positions != [6, 13, 20, 27, 34, 41, 48]
  end

  def winning_color
    check = -> (board) do
      (board & (board >> 1) & (board >> 2) & (board >> 3)) != 0 ||
      (board & (board >> 7) & (board >> 14) & (board >> 21)) != 0 ||
      (board & (board >> 8) & (board >> 16) & (board >> 24)) != 0 ||
      (board & (board >> 6) & (board >> 12) & (board >> 18)) != 0
    end

    if check.call(@boards[:red])
      return Color.new(:red)
    elsif check.call(@boards[:yellow])
      return Color.new(:yellow)
    else
      return nil
    end
  end

  def to_s
    5.step(to: 0, by: -1).map do |row_index|
      (row_index..(row_index + 42)).step(7).map do |index|
        if @boards[:red] & (1 << index) != 0
          "X"
        elsif @boards[:yellow] & (1 << index) != 0
          "O"
        else
          "."
        end
      end.join(' ')
    end.join("\n") + "\n1 2 3 4 5 6 7"
  end

  private

  def initialize(
      next_color,
      boards = {red: 0, yellow: 0},
      next_positions = [0, 7, 14, 21, 28, 35, 42]
    )
    @next_color = next_color
    @boards = boards
    @next_positions = next_positions
  end

  def next_position_after_move(column, positions, index = Column.new(1))
    if index.next.nil?
      []
    elsif index.to_index == column.to_index
      [positions[0] + 1, next_position_after_move(column, positions[1..-1], index.next)].flatten
    else
      [positions[0], next_position_after_move(column, positions[1..-1], index.next)].flatten
    end
  end
end

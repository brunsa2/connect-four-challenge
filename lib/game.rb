require_relative 'board'

# This class is for initializing and running a game. It will
# need a new board and a way to keep track of who is the
# current player. The rest is up to you:
class Game

  attr_accessor :board, :current_player

  WIN = 4

  def initialize
    @board = Board.new
    @current_player = :black
    #@board.print_grid
  end

  def drop_checker(column)
    @board.drop_checker(current_player, column)
    swap_player
  end

  def swap_player
    @current_player = current_player == :black ? :red : :black
  end

  def start
    puts 'A new game has begun!'
  end

  def victory?
    horizontal_victory? || vertical_victory? || diagonal_victory?
  end

  def horizontal_victory?
    board.rows.any? do |row|
      contiguous_count = 0
      row.inject(false) do |state, column|
        if column == current_player
          contiguous_count += 1
        else
          contiguous_count = 0
        end
        state = true if (contiguous_count == WIN)
        state
      end
    end
  end

  def vertical_victory?
    (0...Board::COLUMNS).to_a.any? do |column|
      contiguous_count = 0
      board.rows.inject(false) do |state, row|
        if row[column] == current_player
          contiguous_count += 1
        else
          contiguous_count = 0
        end
        state = true if (contiguous_count == WIN)
        state
      end
    end
  end

  def diagonal_victory?
  end

end

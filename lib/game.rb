require_relative 'board'
require_relative 'column'

# This class is for initializing and running a game. It will
# need a new board and a way to keep track of who is the
# current player. The rest is up to you:
class Game
  def initialize
    @board = Board.starting_with_red
  end

  def start
    while @board.any_valid_move?
      puts @board
      puts "#{@board.next_color} is next. Enter a column 1-7 or q to quit"
      input = gets

      if input == "q\n"
        break
      else
        column = begin
           Column.new(input.to_i)
         rescue
           puts "Bad column"
           next
        end

        begin
          @board = @board.drop_checker(column)
        rescue
          puts "Bad move"
          next
        end
      end

      if (winner = @board.winning_color)
        puts "#{winner} won!"
        break
      end
    end
  end
end

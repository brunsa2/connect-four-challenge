# Use this as a sketch of how your Board class could look, you can fill in these
# methods, or make a different class from scratch
require 'tty-table'

class Board
  attr_reader :table
  attr_accessor :rows

  ROWS = 6
  COLUMNS = 7

  def initialize
    generate_board
  end

  def drop_checker(color, column)
    index = next_free_row_index(column)
    rows[index][column] = color
  end

  def next_free_row_index(column)
    index = ROWS.dup
    rows.reverse.find do |row|
      index -= 1
      row[column].nil?
    end
    return index
  end

  def generate_board
    rows = []
    ROWS.times do
      rows << []
    end

    rows.each do |r|
      COLUMNS.times do
        r << nil
      end
    end
    @rows = rows
  end

  def headers
    [0, 1, 2, 3, 4, 5, 6]
  end

  def print_grid
    @table = TTY::Table.new headers, @rows
    puts @table.render(:ascii, padding: [1, 2, 1, 2])
  end

  def game_won?
    false
  end
end

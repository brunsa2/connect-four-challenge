class Column
  def initialize(number)
    raise ArgumentError, "bad column number" unless number >= 1 && number <= 7
    @number = number
  end

  def to_index
    @number - 1
  end

  def next
    if @number == 7
      nil
    else
      Column.new(@number + 1)
    end
  end
end

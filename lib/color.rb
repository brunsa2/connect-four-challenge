class Color
  def initialize(color)
    raise ArgumentError, 'not a column' unless [:red, :yellow].include?(color)
    @color = color
  end

  def to_sym
    @color
  end

  def to_s
    case @color
    when :red
      'X'
    when :yellow
      'O'
    end
  end

  def opponent_color
    case @color
    when :red
      Color.new(:yellow)
    when :yellow
      Color.new(:red)
    end
  end
end

class Round
  def initialize(input)
    @input = input
  end

  def score
    result_score + shape_score
  end

  def result
    case @input
    when /A Y|B Z|C X/ then :win
    when /A X|B Y|C Z/ then :draw
    when /B X|C Y|A Z/ then :lost
    end
  end

  def shape_score
    case @input.split.last
    when /X/ then 1
    when /Y/ then 2
    when /Z/ then 3
    end
  end

  def result_score
    case result
    when :win then 6
    when :draw then 3
    when :lost then 0
    end
  end
end

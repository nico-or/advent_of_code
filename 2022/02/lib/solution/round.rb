class Round
  CHOICES = %W[A B C]

  def initialize(input)
    @input = input
    @oponent = input.split.first
    @result = input.split.last
    @selection = resolve_round
  end

  def score
    result_score + shape_score
  end

  def result
    case @result
    when /Z/ then :win
    when /Y/ then :draw
    when /X/ then :lost
    end
  end

  def shape_score
    case @selection
    when "A" then 1
    when "B" then 2
    when "C" then 3
    end
  end

  def result_score
    case result
    when :win then 6
    when :draw then 3
    when :lost then 0
    end
  end

  def resolve_round
    reference_index = CHOICES.find_index(@oponent)
    n = CHOICES.length

    case result
    when :win then CHOICES[(reference_index + 1) % n]
    when :draw then CHOICES[(reference_index) % n]
    when :lost then CHOICES[(reference_index - 1) % n]
    end
  end
end

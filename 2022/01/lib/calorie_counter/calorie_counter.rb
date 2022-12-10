class CalorieCounter
  def initialize(input)
    @elves = InputParser.parse(input).map { Elve.new(_1) }
  end

  def max_calories
    @elves.map(&:total_calories).max
  end
end

class CalorieCounter
  def initialize(input)
    @elves = InputParser.parse(input).map { Elve.new(_1) }
  end

  def max_calories(n = 1)
    @elves.map(&:total_calories).max(n).sum
  end
end

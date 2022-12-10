class Game
  def initialize(strategy_input)
    @rounds = strategy_input.split("\n").map { Round.new(_1) }
  end

  def score
    score = @rounds.sum(&:score)
  end
end

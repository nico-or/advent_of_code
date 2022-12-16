class Cycle
  attr_reader :number, :value

  def initialize(number, value)
    @number = number
    @value = value
  end

  def next(diff = 0)
    Cycle.new(number + 1, value + diff)
  end

  def signal_strength
    number * value
  end

  def to_s
    "#{number} #{value} #{signal_strength}"
  end
end

class Elve
  def initialize(input)
    @items = input
  end

  def total_calories
    @items.sum
  end
end

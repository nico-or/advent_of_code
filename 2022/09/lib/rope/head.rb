class Head < RopeNode
  attr_reader :tail

  def initialize(x = 0, y = 0, knot_count = 1)
    @position = Point.new(x, y)
    @tail = Tail.new(self, knot_count - 1)
  end

  def move(instruction)
    direction, steps = instruction.split

    steps.to_i.times do
      case direction
      when "U"
        @position = Point.new(x, y + 1)
      when "D"
        @position = Point.new(x, y - 1)
      when "L"
        @position = Point.new(x - 1, y)
      when "R"
        @position = Point.new(x + 1, y)
      end

      tail.update!
    end
  end

  def knots
    knots = []
    current = self
    while current.tail
      knots << current.tail
      current = current.tail
    end
    knots
  end
end

class Head < RopeNode
  attr_reader :tail

  def initialize(x = 0, y = 0)
    @position = Point.new(x, y)
    @tail = Tail.new(self)
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

      tail.update! unless tail.touching?
    end
  end
end

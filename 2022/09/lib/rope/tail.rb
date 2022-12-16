class Tail < RopeNode
  attr_reader :head, :memory

  def initialize(head)
    @head = head
    @position = head.position.dup
    @memory = [] << position
  end

  def touching?
    distance(head) <= Math.sqrt(2)
  end

  def update!
    dx = head.x <=> x
    dy = head.y <=> y

    @position = Point.new(x + dx, y + dy)
    @memory << position
  end
end

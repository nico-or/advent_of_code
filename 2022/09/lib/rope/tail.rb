class Tail < RopeNode
  attr_reader :head, :memory, :tail

  def initialize(head, knot_count)
    @head = head
    @position = head.position.dup
    @memory = [] << position
    @tail = Tail.new(self, knot_count - 1) unless knot_count.zero?
  end

  def touching?
    distance(head) <= Math.sqrt(2)
  end

  def update!
    return if touching?

    dx = head.x <=> x
    dy = head.y <=> y

    @position = Point.new(x + dx, y + dy)
    @memory << position

    tail.update! if tail
  end
end

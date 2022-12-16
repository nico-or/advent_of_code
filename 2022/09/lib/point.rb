class Point
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def distance(other)
    Math.sqrt(
      (x - other.x) ** 2 +
      (y - other.y) ** 2
    )
  end

  def ==(other)
    if other.instance_of? Array
      return [x, y].eql? other
    elsif other.instance_of? Point
      x == other.x && y == other.y
    else
      raise "invalid type"
    end
  end

  def to_s
    "Point (#{x}, #{y})"
  end
end

class Point
  def self.from_coordinates(array)
    Point.new(array.join(","))
  end

  attr_reader :x, :y, :z

  def initialize(string)
    @x, @y, @z = string.scan(/-?\d+/).map(&:to_i)
  end

  def coordinates
    [x, y, z]
  end

  def adjacent_coordinates
    diffs.map do |dx, dy, dz|
      [x + dx, y + dy, z + dz]
    end
  end

  private

  def diffs
    [
      [1, 0, 0], [-1, 0, 0],
      [0, 1, 0], [0, -1, 0],
      [0, 0, 1], [0, 0, -1],
    ]
  end
end

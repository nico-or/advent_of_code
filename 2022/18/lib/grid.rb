class Grid
  def initialize()
    @grid = Hash.new
  end

  def <<(point)
    @grid[point.coordinates] = point
  end

  def surface_area
    points.sum do |point|
      adjacent_points = point.adjacent_coordinates.count do |position|
        @grid.key?(position)
      end
      6 - adjacent_points
    end
  end

  def exterior_surface_area
    update_limits!
    x_range = Range.new(@x_min - 1, @x_max + 1)
    y_range = Range.new(@y_min - 1, @y_max + 1)
    z_range = Range.new(@z_min - 1, @z_max + 1)

    exterior_area = 0

    visited = []
    stack = []
    stack << Point.from_coordinates([x_range.min, y_range.min, z_range.min])

    until stack.empty?
      current_point = stack.pop
      next if visited.include? current_point.coordinates

      if @grid.key? current_point.coordinates
        exterior_area += 1
        next
      end

      visited << current_point.coordinates

      current_point.adjacent_coordinates.select do |x, y, z|
        x_range.cover?(x) &&
        y_range.cover?(y) &&
        z_range.cover?(z)
      end.each do |coord|
        stack << Point.from_coordinates(coord) unless visited.include? coord
      end
    end

    exterior_area
  end

  private

  def update_limits!
    coords = points.map(&:coordinates)

    @x_min, @x_max = coords.map { |x, y, z| x }.minmax
    @y_min, @y_max = coords.map { |x, y, z| y }.minmax
    @z_min, @z_max = coords.map { |x, y, z| z }.minmax
  end

  def points
    @grid.values
  end
end

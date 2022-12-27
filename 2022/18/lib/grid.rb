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

  private

  def points
    @grid.values
  end
end

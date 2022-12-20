class Reading
  # manhattan distance
  def self.distance(point_1, point_2)
    x1, y1 = point_1
    x2, y2 = point_2
    (x1 - x2).abs + (y1 - y2).abs
  end

  attr_reader :sensor_position, :beacon_position, :range

  def initialize(xs, ys, xb, yb)
    @sensor_position = [xs, ys]
    @beacon_position = [xb, yb]
    @range = Reading.distance(sensor_position, beacon_position)
  end

  def in_range?(position)
    Reading.distance(sensor_position, position) <= range
  end

  # returns positions covered by sensors at a y value
  def scanned_at_y(y_reading)
    x_sensor = sensor_position[0] # should be sensor_position.x
    vertical_position = [x_sensor, y_reading]
    return [] unless in_range?(vertical_position)

    vertical_distance = Reading.distance(sensor_position, vertical_position)
    width = range - vertical_distance
    (x_sensor - width).upto(x_sensor + width).map { |x| [x, y_reading] }
  end
end

require_relative "reading"

filename = ARGV[0]

readings = File.readlines(filename, chomp: true)
  .map { |line| line.scan(/-?\d+/).map(&:to_i) }
  .map { Reading.new(*_1) }

# part 1
puts "Part 1\n#{"-" * 20}"

y_reading = case filename
  when "sample.txt" then 10
  when "input.txt" then 2_000_000
  end

# find all scan-covered positions
covered_positions = readings.flat_map.with_index do |reading, idx|
  puts sprintf("getting coverend positions for sensor %2d/%2d", idx, readings.count)
  reading.scanned_at_y(y_reading)
end.uniq

# remove positions known to be occupied by a beacon or sensor
known_positions = readings.flat_map { [_1.sensor_position, _1.beacon_position] }
filtered_positions = covered_positions.difference(known_positions)

print "\n"
puts "positions covered at y = #{y_reading}: #{filtered_positions.count}"

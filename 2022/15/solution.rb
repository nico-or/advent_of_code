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

# part 2
print "\n" * 2
puts "Part 2\n#{"-" * 20}"

range_limit = case filename
  when "sample.txt"
    x_range = 0..20
    y_range = 0..20
  when "input.txt"
    x_range = 0..4_000_000
    y_range = 0..4_000_000
  end

frontier_positions = readings.flat_map.with_index do |position, idx|
  puts sprintf("getting frontier_positions for sensor %2d/%2d", idx, readings.count)
  position.frontier_positions
end

print "\n"
puts "Positions to search (all) #{frontier_positions.count}"

frontier_positions.select! { |x_pos, y_pos| x_range.include?(x_pos) && y_range.include?(y_pos) }
puts "Positions to search (in bound) #{frontier_positions.count}"

print "\n"
total = frontier_positions.count
digits = Math.log10(total).to_i
report_count = 10

beacon_position = frontier_positions.find.with_index do |position, idx|
  puts sprintf("filtering positions... % 3d%%", idx / total.to_f * 100) if (idx % (total / report_count)).zero?
  readings.none? { |reading| reading.in_range?(position) }
end

def tunning_frequency(position)
  x, y = position
  x * 4_000_000 + y
end

print "\n"
puts "beacon position: #{beacon_position}"
puts "beacon tunning frequency: #{tunning_frequency(beacon_position)}"

# frozen_string_literal: true

require 'csv'

FILENAME = ARGV[0]

lines = File.readlines(FILENAME, chomp: true)

robots = lines.map do |line|
  px, py, vx, vy = line.scan(/-?\d+/).map(&:to_i)
  [Complex(px, py), Complex(vx, vy)]
end

MAX_X = 101
MAX_Y = 103

TIME = MAX_X * MAX_Y

time_series = TIME.times.map do |time|
  positions = robots.map do |pos, vel|
    pos += time * vel
    Complex(pos.real % MAX_X, pos.imag % MAX_Y)
  end
  [time, positions]
end

# original: find with axis variance as metric
class Array
  def mean
    sum / length
  end

  def var
    map(&:abs2).mean - mean.abs2
  end
end
time, grid = time_series.min_by { |_time, positions| positions.map(&:real).var + positions.map(&:imag).var }

# alternative, using part 1's security factor as metric
# time, grid = time_series.min_by do |time,positions|
#   c1 = positions.filter { |pos| pos.real.between?(0,MAX_X/2-1) && pos.imag.between?(0,MAX_Y/2-1) }
#   c2 = positions.filter { |pos| pos.real.between?(MAX_X/2+1, MAX_X-1) && pos.imag.between?(0,MAX_Y/2-1) }
#   c3 = positions.filter { |pos| pos.real.between?(0,MAX_X/2-1) && pos.imag.between?(MAX_Y/2+1, MAX_Y-1) }
#   c4 = positions.filter { |pos| pos.real.between?(MAX_X/2+1, MAX_X-1) && pos.imag.between?(MAX_Y/2+1, MAX_Y-1) }

#   [c1,c2,c3,c4].map(&:count).reduce(&:*)
# end

# print positions
output = 0.upto(MAX_X - 1).map do |dx|
  0.upto(MAX_Y - 1).map do |dy|
    grid.any? { _1.eql? Complex(dx, dy) } ? '#' : ' '
  end
end
puts "time #{time}"
puts output.map(&:join).join("\n")

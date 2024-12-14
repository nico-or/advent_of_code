# frozen_string_literal: true

FILENAME = ARGV[0]

lines = File.readlines(FILENAME, chomp: true)

robots = lines.map do |line|
  px, py, vx, vy = line.scan(/-?\d+/).map(&:to_i)
  [Complex(px, py), Complex(vx, vy)]
end

MAX_X = 101
MAX_Y = 103

TIME = 100

final_robots = robots.map do |pos, vel|
  pos += TIME * vel
  Complex(pos.real % MAX_X, pos.imag % MAX_Y)
end

c1 = final_robots.filter { |pos| pos.real.between?(0, MAX_X / 2 - 1) && pos.imag.between?(0, MAX_Y / 2 - 1) }
c2 = final_robots.filter { |pos| pos.real.between?(MAX_X / 2 + 1, MAX_X - 1) && pos.imag.between?(0, MAX_Y / 2 - 1) }
c3 = final_robots.filter { |pos| pos.real.between?(0, MAX_X / 2 - 1) && pos.imag.between?(MAX_Y / 2 + 1, MAX_Y - 1) }
c4 = final_robots.filter do |pos|
  pos.real.between?(MAX_X / 2 + 1, MAX_X - 1) && pos.imag.between?(MAX_Y / 2 + 1, MAX_Y - 1)
end

puts [c1, c2, c3, c4].map(&:count).reduce(&:*)

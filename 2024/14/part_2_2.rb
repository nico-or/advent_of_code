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

TIME = [MAX_X, MAX_Y].max

# alternative: visually
# plot first iterations

# File.open('out.txt','w') do |f|
#   TIME.times do |time|
#     positions = robots.map do |pos, vel|
#       pos += time * vel
#       Complex(pos.real % MAX_X, pos.imag % MAX_Y)
#     end
#     output = 0.upto(MAX_X - 1).map do |dx|
#       0.upto(MAX_Y - 1).map do |dy|
#         positions.any? { _1.eql? Complex(dx, dy) } ? '#' : ' '
#       end
#     end
#     f.puts "time #{time}"
#     f.puts output.map { _1.join }.join("\n")
#   end
# end

# inspecting the output a pattern emerges where robots clump in each axis
# x coord makes a pattern @t= 62 and repeats every 101 timesteps
# y coord makes a pattern @t= 25 and repeats every 103 timesteps

# Now one must find where the clumping is synchronized
time = 0.upto(MAX_X * MAX_Y).find { |time| ((time-62) % 101 +  (time-25)% 103) == 0 }

positions = robots.map do |pos, vel|
  pos += time * vel
  Complex(pos.real % MAX_X, pos.imag % MAX_Y)
end

output = 0.upto(MAX_X - 1).map do |dx|
  0.upto(MAX_Y - 1).map do |dy|
    positions.any? { _1.eql? Complex(dx, dy) } ? '#' : ' '
  end
end
puts "time #{time}"
puts output.map { _1.join }.join("\n")
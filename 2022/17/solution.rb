require_relative "lib/rock"
require_relative "lib/shaft"

SHAFT_WIDTH = 7
WIND_INPUT = File.read(ARGV[0]).chomp
ROCK_COUNT = ARGV[1].to_i

shaft = Shaft.new(SHAFT_WIDTH, WIND_INPUT)

ROCK_COUNT.times { shaft.new_rock! }
puts "height after #{ROCK_COUNT} rocks have stopped: #{shaft.height} "

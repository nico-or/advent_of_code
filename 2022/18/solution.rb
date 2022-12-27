require_relative "lib/point"
require_relative "lib/grid"

FILENAME = ARGV[0]
INPUT = File.readlines(FILENAME, chomp: true)

DROPLET = Grid.new
CUBES = INPUT.map { |line| Point.new(line) }
CUBES.each { |cube| DROPLET << cube }

puts "Droplet surface area: #{DROPLET.surface_area}"

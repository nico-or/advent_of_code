require_relative "lib/point"
require_relative "lib/grid"

FILENAME = ARGV[0]
INPUT = File.readlines(FILENAME, chomp: true)

DROPLET = Grid.new
CUBES = INPUT.map { |line| Point.new(line) }
CUBES.each { |cube| DROPLET << cube }

puts "Droplet total surface area: #{DROPLET.surface_area}"
puts "Droplet exterior surface area: #{DROPLET.exterior_surface_area}" # 2130, too high

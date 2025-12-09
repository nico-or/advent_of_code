# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename).lines(chomp: true)

points = input.map { |line| line.split(',').map(&:to_i) }

def area(a, b)
  xa, ya = a
  xb, yb = b

  (1 + (xa - xb).abs) * (1 + (ya - yb).abs)
end

areas = points.combination(2).map { |(a, b)| area(a, b) }

p areas.max

# frozen_string_literal: true

ROLL_LIMIT = 4

DELTAS = [-1, 1, 0].product([-1, 1, 0]).reject { it == [0, 0] }

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

roll_set = Set.new

input.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    roll_set << [row, col] if char == '@'
  end
end

sum = 0

roll_set.each do |pos|
  x, y = pos
  adj_count = DELTAS.count do |dx, dy|
    roll_set.include?([x + dx, y + dy])
  end

  sum += 1 if adj_count < ROLL_LIMIT
end

puts sum

# frozen_string_literal: true

ROLL_LIMIT = 4

DELTAS = [
  [1, -1], [1, 0], [1, 1],
  [0, -1], [0, 1],
  [-1, -1], [-1, 0], [-1, 1]
].freeze

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

roll_set = Set.new

input.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    roll_set << [row, col] if char == '@'
  end
end

def adj_pos(pos)
  x, y = pos
  DELTAS.map do |dx, dy|
    [x + dx, y + dy]
  end
end

def adj_count(set, pos)
  x, y = pos
  DELTAS.count do |dx, dy|
    set.include?([x + dx, y + dy])
  end
end

def removable?(set, pos)
  adj_count(set, pos) < ROLL_LIMIT
end

queue = []

roll_set.each do |pos|
  queue << pos if removable?(roll_set, pos)
end

sum = 0

until queue.empty?
  pos = queue.pop
  next unless roll_set.include?(pos)

  sum += 1
  roll_set.delete(pos)

  adj_pos(pos).each do |n_pos|
    queue << n_pos if removable?(roll_set, n_pos)
  end
end

puts sum

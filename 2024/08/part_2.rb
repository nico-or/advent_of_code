# frozen_string_literal: true

filename = ARGV[0]

lines = File.readlines(filename, chomp: true)

ANTENA_REGEX = /[a-zA-Z0-9]/.freeze
ROW_COUNT = lines.length
COL_COUNT = lines.first.length

map = {}

lines.each_with_index do |row, row_idx|
  row.chars.each_with_index do |char, col_idx|
    map[char] = [] unless map.key?(char)
    map[char] << Complex(row_idx, col_idx)
  end
end

def valid_position?(pos, max_row, max_col)
  row = pos.real
  col = pos.imag
  valid_row = row.between?(0, max_row - 1)
  valid_col = col.between?(0, max_col - 1)
  valid_row && valid_col
end

valid_keys = map.keys.filter { ANTENA_REGEX.match? _1 }

# Part 1
def antinode(a, b)
  delta = a - b
  a + delta
end

antinodes = map.slice(*valid_keys).flat_map do |_char, positions|
  positions.repeated_permutation(2)
           .reject { _1[0] == _1[1] }
           .flat_map { |(a, b)| antinode(a, b) }
end

p antinodes.filter { valid_position?(_1, ROW_COUNT, COL_COUNT) }.uniq.count

# Part 2
def resonant(a,b)
  antinodes = []
  n = 0
  delta = a - b
  loop do
    node = a + delta * n
    break unless valid_position?(node, ROW_COUNT, COL_COUNT)

    antinodes << node
    n+=1
  end
  antinodes
end

antinodes = map.slice(*valid_keys).flat_map do |_char, positions|
  positions.repeated_permutation(2)
           .reject { _1[0] == _1[1] }
           .flat_map { |(a, b)| resonant(a, b) }
end

p antinodes.filter { valid_position?(_1, ROW_COUNT, COL_COUNT) }.uniq.count

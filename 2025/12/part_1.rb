# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename)

*piece_input, tree_input = input.split("\n\n")

pieces = piece_input.map do |block|
  _index, piece_str = block.split(":\n")
  piece_str
end

pieces_area = pieces.map { it.count('#') }

trees = tree_input.lines(chomp: true).map do |line|
  rows, cols, *piece_counts = line.scan(/\d+/).map(&:to_i)

  [rows, cols, piece_counts]
end

puts "total trees: #{trees.count}"

filtered_trees = trees.select do |tree|
  rows, cols, piece_count = tree
  area_available = rows * cols

  area_required = piece_count.zip(pieces_area).sum { |c, a| c * a }
  area_required <= area_available
end

puts "filtered trees: #{filtered_trees.count}"

# This turned out to be the correct answer
# It wasn't necessary to actually search through piece rotations and positions

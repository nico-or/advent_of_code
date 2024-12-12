# frozen_string_literal: true

require 'set'

FILENAME = ARGV[0]

lines = File.readlines(FILENAME, chomp: true)

# build map
vertices = {}
lines.each.with_index do |row, row_idx|
  row.chars.each.with_index do |char, col_idx|
    vertices[Complex(row_idx, col_idx)] = char
  end
end

# BFS build regions
directions = [Complex(1, 0), Complex(-1, 0), Complex(0, 1), Complex(0, -1)]
visited = Set.new
regions = []

vertices.each_key do |pos|
  next if visited.include?(pos)

  start = pos
  queue = [pos]
  char = vertices[start]
  region = { char: char, positions: Set.new, area: 0, fences: 0, corners: 0 }

  until queue.empty?
    curr_pos = queue.pop
    next if visited.include?(curr_pos) ||   # visited
            !vertices.key?(curr_pos) ||     # outside map
            !vertices[curr_pos].eql?(char)  # other crop

    visited << curr_pos
    neighbours = directions.map { |delta| curr_pos + delta }
    neighbours.each { |pos| queue << pos }

    # updates
    region[:positions] << curr_pos
    region[:area] += 1

    # fence if encountering another crop
    region[:fences] += neighbours.reject { |pos| vertices[pos].eql?(char) }.count

    # corners!
    square = [Complex(0, 0), Complex(1, 0), Complex(0, 1), Complex(1, 1)]
    convolutions = (0..3).map do |count|
      square.map { |pos| pos * Complex(0, 1)**count } # rotate vector 'count' times
    end

    # case 1: [[A,B],[B,B]]
    convolutions.each do |pattern|
      chars = pattern.map { |delta| vertices[curr_pos + delta] }
      char_count = chars.count { _1.eql?(char) }
      region[:corners] += 1 if char_count.eql?(1)
      # case 2: [[A,A],[A,B]]
      chars = pattern.map { |delta| vertices[curr_pos + delta] }
      char_count = chars.count { _1.eql?(char) }
      oposite_corner = chars[-1]
      region[:corners] += 1 if char_count.eql?(3) && !oposite_corner.eql?(char)
      # case 3: [[A,B],[B,A]]
      chars = pattern.map { |delta| vertices[curr_pos + delta] }
      char_count = chars.count { _1.eql?(char) }
      oposite_corner = chars[-1]
      region[:corners] += 1 if char_count.eql?(2) && oposite_corner.eql?(char)
    end
  end
  regions << region
end

# part 2
p regions.reduce(0) { |acc, region| acc + region[:area] * region[:corners] }

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
directions = [   Complex(1,0),   Complex(-1,0),   Complex(0,1),   Complex(0,-1) ]
region_queue = Queue.new << Complex(0,0)

regions = []
region_visited = Set.new

until region_queue.empty?
  region = {char:nil, fences:0, area: 0}
  start = region_queue.pop
  next if region_visited.include?(start)
  search_queue = [start]
  visited = Set.new
  region[:char] = vertices[start]

  until search_queue.empty?
    curr_pos = search_queue.shift
    next if visited.include? curr_pos
    visited << curr_pos
    region_visited << curr_pos
    neighbours = directions.map { |delta| curr_pos + delta }

    # add area
    region[:area] += 1

    # count fences
    foreign_regions = neighbours.reject { |pos| vertices[pos].eql?(region[:char]) }
    region[:fences] += foreign_regions.count
    foreign_regions.reject{ |pos| vertices[pos].nil? }.each { region_queue << _1 }
    # add neighbours to queue
    neighbours.filter { |pos| vertices[pos].eql?(region[:char]) }
              .reject { |pos| vertices[pos].nil? }
              .each { |pos| search_queue << pos }
  end
  regions << region
end

p regions.reduce(0) { |acc, region| acc + region[:fences] * region[:area] }
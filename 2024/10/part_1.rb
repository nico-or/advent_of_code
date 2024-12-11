# frozen_string_literal: true

filename = ARGV[0]

lines = File.readlines(filename, chomp: true)

heights = {}
edges = {}
trailheads = []

lines.each_with_index do |row, row_idx|
  row.chars.each_with_index do |height, col_idx|
    pos = Complex(row_idx, col_idx)
    trailheads << pos if height.to_i.eql?(0)

    heights[pos] = [] unless heights.key?(pos)
    heights[pos] = height.to_i
  end
end

DIRECTIONS = [Complex(1,0), Complex(-1,0), Complex(0,1), Complex(0,-1)]
heights.keys.each do |from|
  edges[from] = DIRECTIONS.filter_map do |delta|
    to = from + delta
    h_to = heights[to]
    next if h_to.nil?

    h_from = heights[from]
    diff = h_to - h_from
    diff.eql?(1) ? to : nil
  end
end

trails = trailheads.map do |start|
  peaks = []
  stack = [start]
  until stack.empty?
    curr = stack.pop
    peaks << curr if heights[curr].eql?(9)

    edges[curr].each { stack << _1 }
  end
  peaks
end

puts trails.reduce(0) { |acc, arr| acc + arr.uniq.count }
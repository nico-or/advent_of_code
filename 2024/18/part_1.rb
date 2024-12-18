# frozen_string_literal: true

require 'set'

require_relative 'min_queue'

FILENAME = ARGV[0]

lines = File.readlines(FILENAME, chomp: true)

BYTES = lines.map do |line|
  line.scan(/\d+/).map(&:to_i).then { |(x,y)| Complex(x,y) }
end

XSIZE = YSIZE = 70
BYTE_COUNT = 1024

VERTICES = {}
(0..XSIZE).each do |row_idx|
  (0..YSIZE).each do |col_idx|
    pos = Complex(row_idx, col_idx)
    VERTICES[pos] = '.'
  end
end

BYTES.first(BYTE_COUNT).each { |pos| VERTICES[pos] = '#'}

DIRECTIONS = [Complex(1,0), Complex(-1,0), Complex(0,1),Complex(0,-1)]
def neighbours(pos)
  DIRECTIONS.map { |dir| pos + dir }
end

EDGES = Hash.new
VERTICES.keys.each do |from|
  next if EDGES[from].eql?('#')

  neighbours(from).each do |to|
    next if VERTICES[to].eql?('#')
    next unless to.real.between?(0,XSIZE)
    next unless to.imag.between?(0,YSIZE)
    EDGES[from] = [] unless EDGES.key? from
    EDGES[from] << to
  end
end

def dijkstra(edges, start_pos)
  prev = Hash.new
  distances = Hash.new(Float::INFINITY)
  queue = MinQueue.new
  visited = Set.new
  queue.push([start_pos,0],0)

  until queue.empty?
    key_from, curr_distance = queue.pop
    next if visited.include?(key_from)
    visited << key_from
    distances[key_from] = [distances[key_from], curr_distance].min

    neighbours = edges[key_from] || []
    neighbours.each do |key_to|
      new_score = curr_distance + 1
      prev[key_to] = key_from if new_score < distances[key_to]
      queue.push([key_to, new_score], new_score)
    end
  end
  [distances, prev]
end

START_POS = Complex(0,0)
END_POS = Complex(XSIZE,YSIZE)

_, prev = dijkstra(EDGES, START_POS)

# reconstruct path
path = [END_POS]
path << prev[path.last] while prev.key?(path.last)
p path.length - 1

# string representation
# out = (0..XSIZE).map do |row_idx|
#   (0..YSIZE).map do |col_idx|
#     pos = Complex(row_idx, col_idx)
#     next 'S' if pos.eql? START_POS
#     next 'E' if pos.eql? END_POS
#     path.include?(pos) ? 'O' : VERTICES[pos]
#   end.join
# end.join("\n")
# puts out

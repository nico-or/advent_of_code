# frozen_string_literal: true

require 'set'

require_relative 'min_queue'

FILENAME = ARGV[0]

lines = File.readlines(FILENAME, chomp: true)

BYTES = lines.map do |line|
  line.scan(/\d+/).map(&:to_i).then { |(x,y)| Complex(x,y) }
end

XSIZE = YSIZE = 70
VERTICES = {}
(0..XSIZE).each do |row_idx|
  (0..YSIZE).each do |col_idx|
    pos = Complex(row_idx, col_idx)
    VERTICES[pos] = '.'
  end
end

DIRECTIONS = [Complex(1,0), Complex(-1,0), Complex(0,1),Complex(0,-1)]
def neighbours(pos)
  DIRECTIONS.map { |dir| pos + dir }
end

def build_edges(vertices, index)
  bytes = BYTES[..index].to_set
  edges = Hash.new
  vertices.keys.each do |from|
    next if bytes.include? from
    neighbours(from).each do |to|
      next if bytes.include? to
      next unless to.real.between?(0,XSIZE)
      next unless to.imag.between?(0,YSIZE)
      edges[from] = [] unless edges.key? from
      edges[from] << to
    end
  end
  edges
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

def path_length(edges,from, to)
  dists, _ = dijkstra(edges, from)
  dists[to]
end

START_POS = Complex(0,0)
END_POS = Complex(XSIZE,YSIZE)

idx_left = 0
idx_right = BYTES.length - 1

byte_pos = loop do
  idx_middle = idx_left + (idx_right - idx_left) / 2
  break BYTES[idx_right] if [idx_left, idx_right].any? { _1.eql? idx_middle }

  edges_middle =  build_edges(VERTICES, idx_middle)
  dist_middle = path_length(edges_middle,START_POS,END_POS)

  if dist_middle < Float::INFINITY
    idx_left = idx_middle
  else
    idx_right = idx_middle
  end
end

puts "#{byte_pos.real},#{byte_pos.imag}"
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

BYTES.each { |pos| VERTICES[pos] = '#' }

byte = BYTES.reverse_each do |byte_pos|
  VERTICES[byte_pos] = '.'

  edges = Hash.new
  VERTICES.keys.each do |from|
    next if edges[from].eql?('#')

    neighbours(from).each do |to|
      next if VERTICES[to].eql?('#')
      next unless to.real.between?(0,XSIZE)
      next unless to.imag.between?(0,YSIZE)
      edges[from] = [] unless edges.key? from
      edges[from] << to
    end
  end

  dists, _ = dijkstra(edges, START_POS)
  break "#{byte_pos.real},#{byte_pos.imag}" if dists[END_POS] < (Float::INFINITY)
end

puts byte
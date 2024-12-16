# frozen_string_literal: true

require 'set'

require_relative 'min_queue'

FILENAME = ARGV[0]

input = File.readlines(FILENAME, chomp: true)

VERTICES = {}
input.each_with_index do |row, row_idx|
  row.chars.each_with_index do |char, col_idx|
    VERTICES[Complex(row_idx, col_idx)] = char
  end
end

def neighbours(pos,dir)
  [
    [[pos+dir,dir],1],
    [[pos, dir * Complex(0, 1)],1000],
    [[pos, dir * Complex(0, -1)],1000]
  ]
end

DIRECTIONS = [Complex(1,0), Complex(-1,0), Complex(0,1),Complex(0,-1)]

EDGES = Hash.new
SCORES = Hash.new(Float::INFINITY)

VERTICES.keys.each do |pos|
  DIRECTIONS.each do |dir|
    key_from = [pos,dir]
    EDGES[key_from] = [] unless EDGES.key? key_from
    neighbours(pos,dir).each do |(key_to, score)|
      next if VERTICES[key_to[0]].eql?('#')
      key = [key_from, key_to]
      EDGES[key_from] << key_to
      SCORES[key] = [SCORES[key], score].min
    end
  end
end

START_POS = VERTICES.key 'S'
END_POS = VERTICES.key 'E'
START_DIR = Complex(0, -1)
START_SCORE = 0

def dijkstra(edges, weigths, start_key)
  distances = Hash.new(Float::INFINITY)
  queue = MinQueue.new
  visited = Set.new
  queue.push([start_key, 0], 0)

  until queue.empty?
    key_from, curr_distance = queue.pop
    next if visited.include?(key_from)
    visited << key_from
    distances[key_from] = [distances[key_from], curr_distance].min

    neighbours = edges[key_from] || []
    neighbours.each do |key_to|
      key = [key_from, key_to]
      new_score = curr_distance + weigths[key]
      new_priority = new_score
      queue.push([key_to, new_score], new_priority)
    end
  end
  distances
end

scores_from_start = dijkstra(EDGES, SCORES,  [START_POS, START_DIR])
scores_from_end = DIRECTIONS.map { |dir| dijkstra(EDGES, SCORES, [END_POS,dir]) }
                            .map! { _1.transform_keys { |(pos,dir)| [pos,dir*Complex(-1,0)] } }   # turn 180-deg all dirs to match from-start direction
                            #.reduce { |acc,h| acc.merge(h) { |k,v_old,v_new| [v_old, v_new].min } } # keep min score between all end directions

p MIN_SCORE = scores_from_start.select { |k, _| k.first.eql? END_POS }
                             .values
                             .min

keys_from = VERTICES.keys.flat_map do |pos|
  DIRECTIONS.map do |dir|
    [pos, dir]
  end
end

keys = keys_from.select do |key|
  scores_from_end.any? do |scores|
    score_start = scores_from_start[key] || Float::INFINITY
    score_end = scores[key] || Float::INFINITY
    score_start + score_end <= MIN_SCORE
  end
end

puts keys.map { _1.first }.uniq.count
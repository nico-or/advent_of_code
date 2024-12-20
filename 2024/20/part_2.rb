# frozen_string_literal: true

require 'set'

FILENAME = ARGV[0]

input = File.readlines(FILENAME, chomp: true)

vertices = {}
input.each_with_index do |row, row_idx|
  row.chars.each_with_index do |char, col_idx|
    pos = Complex(row_idx, col_idx)
    vertices[pos] = char
  end
end

def neighbours(pos)
  directions = [Complex(1, 0), Complex(-1, 0), Complex(0, 1), Complex(0, -1)]
  directions.map { _1 + pos }
end

edges = {}
vertices.each_key do |from_pos|
  neighbours = neighbours(from_pos)
  edges[from_pos] = neighbours.reject { |to_pos| [nil, '#'].include? vertices[to_pos] }
end

START_POS = vertices.key 'S'
END_POS = vertices.key 'E'

def bfs(edges, start)
  prev = {}
  queue = Queue.new
  queue << start
  visited = Set.new
  until queue.empty?
    curr_pos = queue.pop
    next if visited.include? curr_pos

    visited << curr_pos
    edges[curr_pos].each do |next_pos|
      next if visited.include? next_pos

      prev[next_pos] = curr_pos
      queue << next_pos
    end
  end
  prev
end

def rebuild_path(prev, from, to)
  path = [to]
  while (last = prev[path.last])
    path << last
  end
  path.reverse if path.last.eql?(from)
end

prev = bfs(edges, START_POS)
path = rebuild_path prev, START_POS, END_POS

def manhattan_distance(pos_a, pos_b)
  x_a, y_a = pos_a.rect
  x_b, y_b = pos_b.rect
  (x_a - x_b).abs + (y_a - y_b).abs
end

MAX_CHEAT_DISTANCE = 20
MIN_DIST_SAVED = 100

count = 0

(0...path.length).each do |start_idx|
  (start_idx + 1...path.length).each do |end_idx|
    dist = manhattan_distance(path[start_idx], path[end_idx])
    next if dist > MAX_CHEAT_DISTANCE

    orig_dist = end_idx
    new_dist = start_idx + dist
    delta = new_dist - orig_dist

    count += 1 if delta <= -1 * MIN_DIST_SAVED
  end
end

p count

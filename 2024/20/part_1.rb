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

cheat_jumps = [Complex(2, 0), Complex(-2, 0), Complex(0, 2), Complex(0, -2)]

path_idx = {}
path.each_with_index { |pos, idx| path_idx[pos] = idx }

possible_cheats = path.flat_map do |start_pos|
  cheat_jumps.filter_map do |delta|
    end_pos = start_pos + delta
    if (end_dist = path_idx[end_pos])
      start_dist = path_idx[start_pos]
      jump_distance = delta.abs # always 2
      dist_original = end_dist
      dist_cheat = start_dist + jump_distance
      net_disttance = dist_cheat - dist_original

      [start_pos, end_pos, net_disttance]
    end
  end
end

p possible_cheats.filter { _1.last <= -100 }.count

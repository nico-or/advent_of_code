# frozen_string_literal: true

require 'set'

filename = ARGV[0]

map = File.readlines(filename, chomp: true).map(&:chars)

module Char
  GUARD = '^'
  WALL = '#'
  EMPTY = '.'
end

module Direction
  UP = [-1, 0].freeze
  DOWN = [1, 0].freeze
  RIGHT = [0, 1].freeze
  LEFT = [0, -1].freeze

  # 90 deg right rotation
  def self.rotate(direction)
    case direction
    when UP then RIGHT
    when RIGHT then DOWN
    when DOWN then LEFT
    when LEFT then UP
    end
  end

  def self.move(pos, direction)
    x1, y1 = pos
    x2, y2 = direction
    [x1 + x2, y1 + y2]
  end

  def self.char(direction)
    case direction
    when Direction::UP then '^'
    when Direction::DOWN then 'v'
    when Direction::LEFT then '<'
    when Direction::RIGHT then '>'
    end
  end
end

start_row = map.find_index { _1.include? Char::GUARD }
start_col = map[start_row].find_index(Char::GUARD)

curr_pos = [start_row, start_col]
curr_dir = Direction::UP

# fix bug when guard walks through start position
map[curr_pos[0]][curr_pos[1]] = Char::EMPTY

visited = {}

visited[curr_pos] = curr_dir

loop do
  next_pos = Direction.move(curr_pos, curr_dir)
  case map.dig(*next_pos)
  when Char::EMPTY
    curr_pos = next_pos
    visited[curr_pos] = curr_dir
  when Char::WALL
    curr_dir = Direction.rotate(curr_dir)
  else
    break
  end
end

def generate_map(array, visited)
  array.map.each_with_index do |row, row_idx|
    row.map.each_with_index do |char, col_idx|
      pos = [row_idx, col_idx]
      visited.key?(pos) ? Direction.char(visited[pos]) : char
    end.join
  end.join("\n")
end

puts generate_map(map, visited)
puts "visited: #{visited.count} positions"

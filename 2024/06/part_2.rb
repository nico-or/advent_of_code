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

def generate_map(array, visited)
  unique = visited.each_with_object({}) do |entry, acc|
    acc[entry[0]] = Direction.char(entry[1])
  end

  array.map.each_with_index do |row, row_idx|
    row.map.each_with_index do |char, col_idx|
      pos = [row_idx, col_idx]
      unique[pos] || char
    end.join
  end.join("\n")
end

START_ROW = map.find_index { _1.include? Char::GUARD }
START_COL = map[START_ROW].find_index(Char::GUARD)
START_POS = [START_ROW, START_COL].freeze
START_DIR = Direction::UP

# fix bug when guard walks through start position
map[START_ROW][START_COL] = Char::EMPTY

def step(map, pos, dir)
  curr_pos = pos
  curr_dir = dir

  loop do
    next_pos = Direction.move(curr_pos, curr_dir)
    break if next_pos.any?(&:negative?)

    case map.dig(*next_pos)
    when Char::EMPTY
      curr_pos = next_pos
      return [curr_pos, curr_dir]
    when Char::WALL
      curr_dir = Direction.rotate(curr_dir)
    else
      break
    end
  end
end

pos = START_POS
dir = START_DIR
visited = [[pos, dir]]

loop do
  new_pos, new_dir = step(map, pos, dir)
  break unless new_pos

  pos = new_pos
  dir = new_dir
  visited << [pos, dir]
end

uniq_visited = visited.map { _1[0] }.uniq
puts "visited: #{uniq_visited.count} positions"

main_tic = Time.now
walls = uniq_visited[1..].filter_map.each_with_index do |wall_pos, index|
  iter_tic = Time.now

  x, y = wall_pos
  map[x][y] = Char::WALL

  pos = START_POS
  dir = START_DIR

  memo = Set.new << [START_POS, START_DIR]

  is_loop = loop do
    new_pos, new_dir = step(map, pos, dir)
    break false unless new_pos
    break true if memo.include?([new_pos, new_dir])

    pos = new_pos
    dir = new_dir
    memo << [pos, dir]
  end

  if (index % 50).zero?
    puts "Total: #{Time.now - main_tic} It: #{Time.now - iter_tic} Progress: #{index + 1}/#{uniq_visited[1..].count}"
  end

  map[x][y] = Char::EMPTY

  is_loop ? wall_pos : nil
end

puts "wall count: #{walls.uniq.count}"

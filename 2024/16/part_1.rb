# frozen_string_literal: true

require 'set'

require_relative 'min_queue'

FILENAME = ARGV[0]

input = File.readlines(FILENAME, chomp: true)

vertices = {}
input.each_with_index do |row, row_idx|
  row.chars.each_with_index do |char, col_idx|
    vertices[Complex(row_idx, col_idx)] = char
  end
end

def turn_left(dir)
  dir * Complex(0, 1)
end

def turn_right(dir)
  dir * Complex(0, -1)
end

START_DIR = Complex(0, -1)
START_POS = vertices.key 'S'
END_POS = vertices.key 'E'

queue = MinQueue.new
visited = Set.new

queue.push([START_POS, START_DIR, 0], 0)

best_score = loop do
  curr_pos, curr_dir, curr_score = queue.pop
  break curr_score if curr_pos.eql? END_POS
  next if visited.include?([curr_pos, curr_dir])

  visited << [curr_pos, curr_dir]

  # forward
  new_pos = curr_pos + curr_dir
  new_dir = curr_dir
  new_score = curr_score + 1
  queue.push([new_pos, new_dir, new_score], new_score) unless vertices[new_pos].eql?('#')

  # turn left
  new_pos = curr_pos
  new_dir = turn_left(curr_dir)
  new_score = curr_score + 1000
  queue.push([new_pos, new_dir, new_score], new_score) unless vertices[new_pos].eql?('#')

  # turn right
  new_pos = curr_pos
  new_dir = turn_right(curr_dir)
  new_score = curr_score + 1000
  queue.push([new_pos, new_dir, new_score], new_score) unless vertices[new_pos].eql?('#')
end

puts best_score

# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.readlines(FILENAME,chomp: true)

edges = Hash.new { Array.new }
input.each do |line|
  pc_a, pc_b = line.split('-')
  edges[pc_a] = edges[pc_a] << pc_b
  edges[pc_b] = edges[pc_b] << pc_a
end

vertices = edges.keys

CYCLE_SIZE = 3

def expand(edges, path, depth, max_depth)
  return path if depth.eql? max_depth

  last_pos = path.last
  edges[last_pos].map do |next_pos|
    expand(edges, [*path, next_pos], depth + 1, max_depth)
  end
end

# all 3 length paths
paths = vertices.map do |start|
  expand(edges, [start], 0, CYCLE_SIZE)
end

def is_cycle(path)
  path.first == path.last
end

def is_valid(path)
  path.uniq.count.eql? CYCLE_SIZE
end

# all 3 length cycles
cycles = paths.flatten(3).filter do |path|
  is_cycle(path) && is_valid(path)
end

# all unique cycles
unique_cycles = cycles.map { _1.first(3).sort }.uniq

# cycles with 't' computer
p unique_cycles.count { |path| path.any? { |computer| computer.start_with?('t') } }
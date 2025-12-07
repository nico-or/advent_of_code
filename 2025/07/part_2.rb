# frozen_string_literal: true

START = 'S'
SPACE = '.'
SPLITTER = '^'

filename = ARGV[0] || 'sample.txt'

input = File.read(filename).lines(chomp: true)

rays = Set.new

START_IDX = input.first.index(START)

rays << START_IDX

graph = Hash.new { |hash, key| hash[key] = [] }

sum = 0

input[1..].each.with_index do |line, line_idx|
  n_rays = Set.new

  line.each_char.with_index do |char, char_idx|
    next unless rays.include?(char_idx)

    key = [line_idx, char_idx]

    case char
    when SPACE
      n_rays << char_idx

      graph[key] << [line_idx + 1, char_idx]
    when SPLITTER
      sum += 1
      n_rays << (char_idx - 1)
      n_rays << (char_idx + 1)

      graph[key] << [line_idx + 1, char_idx - 1]
      graph[key] << [line_idx + 1, char_idx + 1]
    end
  end

  rays = n_rays
end

def sum_rec(graph, pos, memo = {})
  return memo[pos] if memo.key? pos

  unless graph.key? pos
    return 1
  end

  memo[pos] = graph[pos].sum { |next_pos| sum_rec(graph, next_pos, memo) }
end

start_pos = [0, START_IDX]
p sum_rec(graph, start_pos)
# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename).lines(chomp: true)

GRAPH = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  node, targets = line.split(': ')

  targets.split.each do |target|
    GRAPH[node] << target
  end
end

def dfs(node, target, graph, count = 0, memo = {})
  return memo[node] if memo.key?(node) # already visited
  return memo[node] = 1 if node == target # good leaf
  return memo[node] = 0 unless graph.key?(node) # bad leaf

  memo[node] = count + graph[node].sum { |child| dfs(child, target, graph, count, memo) }
end

p [
  dfs('svr', 'fft', GRAPH),
  dfs('fft', 'dac', GRAPH),
  dfs('dac', 'out', GRAPH)
].reduce(:*)

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

cliques = vertices.map do |at_pos|
  clique = [at_pos]
  edges[at_pos].each do |to_pos|
    clique << to_pos if clique.all? { edges[to_pos].include? _1 }
  end
  clique
end

p cliques.map { _1.sort}.max_by(&:length).sort.join(',')
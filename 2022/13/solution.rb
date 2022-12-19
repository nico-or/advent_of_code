require "json"
require_relative "lib/ordered"

packets = File.readlines(ARGV[0], chomp: true).reject(&:empty?).map { JSON.parse(_1) }

# part 1
p packets
    .each_slice(2)
    .filter_map.with_index { |pair, idx| (idx + 1) if ordered?(*pair) }
    .sum

# part 2
dividers = [[[2]], [[6]]]

packets += dividers

p packets
    .sort { |a, b| ordered?(a, b) ? -1 : 1 } # block has to implement <=> behaviour
    .filter_map.with_index { |packet, entry| (entry + 1) if dividers.include? packet }
    .reduce(1, :*)

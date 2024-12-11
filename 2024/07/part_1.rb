# frozen_string_literal: true

require 'benchmark'

filename = ARGV[0]

entries = File.readlines(filename, chomp: true).map do |line|
  head,*tail = line.scan(/\d+/).map(&:to_i)
  [head, tail]
end

valid = entries.filter do |value, factors|
  aux = [factors.first]
  factors[1..].each do |num|
    aux = aux.flat_map { [_1 + num, _1 * num] }
  end
  aux.include? value 
end

puts valid.sum { _1.first }

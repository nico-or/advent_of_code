# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

even, odd = input
            .scan(/\d+/)
            .map(&:to_i)
            .partition
            .with_index { |_n, i| i.even? }

[even, odd].each(&:sort!)

distance = even
  .zip(odd)
  .map { |a, b| b - a }
  .map(&:abs)
  .sum

puts "total distance: #{distance}"

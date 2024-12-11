# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

even, odd = input
            .scan(/\d+/)
            .map(&:to_i)
            .partition
            .with_index { |_n, i| i.even? }

even_hash, odd_hash = [even, odd].map(&:tally)

score = even_hash.map { |k, v| k * v * odd_hash.fetch(k, 0) }.sum

puts "similarity score: #{score}"

# frozen_string_literal: true

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

BANK_LEN = input.first.length
sum = 0

input.each do |line|
  values = line.chars.map(&:to_i)

  first = values[...(BANK_LEN - 1)].max
  first_idx = values.find_index(first)

  last = values[(first_idx + 1)..].max

  sum += (first * 10) + last
end

puts sum

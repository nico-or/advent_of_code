# frozen_string_literal: true

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

ranges = []
items = []

input.each do |line|
  case line.scan(/\d+/).map(&:to_i)
  in [first, last]
    ranges << Range.new(first, last)
  in [val]
    items << val
  else
  end
end

sum = 0 

items.each do |i|
  sum += 1 if ranges.any? { |r| r.include?(i) }
end

puts sum

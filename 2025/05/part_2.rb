# frozen_string_literal: true

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

ranges = []

input.each do |line|
  case line.scan(/\d+/).map(&:to_i)
  in [first, last]
    ranges << Range.new(first, last)
  else
  end
end

ranges.sort_by!(&:minmax)

merged = []

current = ranges.first

ranges[1..].each do |range|
  if range.first <= current.last
    current = Range.new(current.first, range.last)
  else
    merged << current
    current = range
  end
end

merged << current

puts merged.sum(&:size)

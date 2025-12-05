# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename, chomp: true)

ranges = input.scan(/\d+/).map(&:to_i).each_slice(2)

# matches values like: 11, 111, 1212, 121212
regex = /^(\d+)\1+$/
sum = 0

# slow, takes almost 1 second
ranges.each do |(first, last)|
  values = first.upto(last)
  sum += values.select { regex.match? it.to_s }.sum
end

puts sum

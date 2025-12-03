# frozen_string_literal: true

def max_joltage(bank, count, prev = '')
  return (prev + bank.max).to_i if count == 1

  max_val = bank[...-(count - 1)].max
  max_idx = bank.find_index(max_val)

  new_val = prev + max_val
  new_rank = bank[(max_idx + 1)..]

  max_joltage(new_rank, count - 1, new_val)
end

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

BATTERY_COUNT = 12
sum = 0

input.each do |line|
  sum += max_joltage(line.chars, BATTERY_COUNT)
end

puts sum

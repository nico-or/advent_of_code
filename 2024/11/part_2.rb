# frozen_string_literal: true

FILENAME = ARGV[0]
BLINK_COUNT = ARGV[1].to_i

digits = File.read(FILENAME).scan(/\d+/).map(&:to_i)

def divide(stone)
  digits = Math.log10(stone).floor + 1
  aux = 10**(digits / 2)
  pre = stone / aux
  post = stone % aux
  [pre, post]
end

def blink(stone, memo)
  return memo[stone] if memo.key?(stone)

  out = if stone.zero?
          [1]
        elsif stone.digits.count.even?
          divide(stone)
        else
          [stone * 2024]
        end
  memo[stone] = out
end

stones = digits.tally

memo = {}

BLINK_COUNT.times do |blink|
  stones = stones.each_with_object(Hash.new(0)) do |(stone, count), acc|
    blink(stone, memo).each do |new_stone|
      acc[new_stone] += count
    end
  end
end

puts stones.values.sum

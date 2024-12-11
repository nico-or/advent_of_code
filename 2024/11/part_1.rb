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

stones = digits

memo = {}

BLINK_COUNT.times do |blink|
  stones = stones.flat_map do |stone|
    blink(stone, memo)
  end
end

puts stones.count

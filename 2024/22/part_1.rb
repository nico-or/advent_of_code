# frozen_string_literal: true

FILENAME = ARGV[0]

numbers = File.readlines(FILENAME, chomp: true).map(&:to_i)

def mix(a, b)
  a ^ b
end

def prune(a)
  a % 16777216
end

def next_num(num)
  num = prune(mix(num*64, num))
  num = prune(mix(num/32, num))
  num = prune(mix(num*2048, num))
end

NUMBER_COUNT = 2_000

NUMBER_COUNT.times do 
  numbers  = numbers.map { next_num _1 }
end

p numbers.sum
# frozen_string_literal: true

def mix(a, b)
  a ^ b
end

def prune(a)
  a % 16_777_216
end

def next_num(num)
  num = prune(mix(num * 64, num))
  num = prune(mix(num / 32, num))
  num = prune(mix(num * 2048, num))
end

FILENAME = ARGV[0]

numbers = File.readlines(FILENAME, chomp: true).map(&:to_i)

NUMBER_COUNT = 2_000

numbers = numbers.map do |num|
  out = [num]
  NUMBER_COUNT.times { out << next_num(out.last) }
  out
end

prices = numbers.map { |seq| seq.map { _1 % 10 } }

# arrays with [number, preceding sequence]
foo = prices.map do |seq|
  seq.each_cons(5).map do |seq|
    [seq.last, seq.each_cons(2).map { _2 - _1 }]
  end
end

# hashes with: sequence => frist number associated with it
bar = foo.map do |seq|
  seq.each_with_object({}) do |(num, seq), hash|
    hash[seq] ||= num
  end
end

# for all number sequences, sum the total value of each sequence
totals = bar.each_with_object(Hash.new(0)) do |hash, acc|
  hash.each { |seq, num| acc[seq] += num }
end

p(totals.max_by { |_k, v| v })

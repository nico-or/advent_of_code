# frozen_string_literal: true

filename = ARGV[0]

entries = File.readlines(filename, chomp: true).map do |line|
  head, *tail = line.scan(/\d+/).map(&:to_i)
  [head, tail]
end

def concatenate(a, b)
  # 2x slower
  # "#{a}#{b}".to_i

  # 10% slower than current
  # digits = 1 + Math.log10(b).floor
  # a * 10 ** digits + b

  a_ = a
  b_ = b
  while b_.positive?
    b_ /= 10
    a_ *= 10
  end
  a_ + b
end

valid = entries
        .lazy
        .filter { |v, f| v >= f.reduce(:+) }
        .filter { |v, f| v <= f.reduce(:*) }
        .filter do |value, factors|
  aux = [factors.first]
  factors[1..].each do |num|
    aux = aux.flat_map { [_1 + num, _1 * num, concatenate(_1, num)] }
  end
  aux.include? value
end

puts valid.sum(&:first)

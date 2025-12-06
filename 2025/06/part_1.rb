# frozen_string_literal: true

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

N_ROW = input.count
N_COL = input.first.split.count

parsed = Array.new(N_COL) { [] }

input.each_with_index do |line, _row|
  line.split.each_with_index do |char, col|
    parsed[col] << char
  end
end

sum = 0

parsed.each do |arr|
  op = arr.last
  num = arr[..-2].map(&:to_i)

  case op
  when '+'
    sum += num.reduce(&:+)
  when '*'
    sum += num.reduce(&:*)
  end
end

puts sum

# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename).chars.map(&:to_i)


counter = -1
memory = input.flat_map.with_index do |digit, index|
  case index % 2
  when 0 
    counter += 1
    digit.times.map { counter }
  else
    digit.times.map { nil }
  end
end

l_idx = 0
r_idx = memory.length - 1

loop do
  if memory[l_idx].nil?
    r_idx -= 1 while memory[r_idx].nil?
    break if l_idx >= r_idx

    memory[l_idx], memory[r_idx] = memory[r_idx], memory[l_idx]
  end
  l_idx += 1
end

p memory.map { _1.nil? ? 0 : _1 }
        .map.with_index { |v,i| v * i }
        .sum

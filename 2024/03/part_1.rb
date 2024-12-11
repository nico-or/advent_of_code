# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

instructions = input.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)

def multiply(instruction)
  instruction
  .scan(/\d+/)
  .map(&:to_i)
  .reduce(:*)
end

puts "sum: #{instructions.sum { |ins| multiply(ins) }}"
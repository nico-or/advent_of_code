# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

p instructions = input.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)|don't\(\)|do\(\)/)

def multiply(instruction)
  instruction
    .scan(/\d+/)
    .map(&:to_i)
    .reduce(:*)
end

status = true

total = instructions.sum do |ins|
  if ins.eql? 'do()'
    status = true
    next 0
  end

  if ins.eql? "don't()"
    status = false
    next 0
  end

  status ? multiply(ins) : 0
end

puts "sum: #{total}"

# frozen_string_literal: true

require_relative 'chronospatial_computer'

FILENAME = ARGV[0]

input = File.read(FILENAME)
instructions = input.scan(/\d+/).map(&:to_i)

original_instructions = instructions[3..]
orig_output = original_instructions.join(',')

queue = [0]
found = []


# After manually inspecting the program instructions, it becomes evident that
# the A register is divided by 8 every loop while outputing the values for register B.
#
# Representing this as a binary number, every loop 3 bits are removed from A, so the last number
# gets computed by only 3 bits, the second-to-last number gets computed with the previous 3bit
# number shifted plus 1 3bit number more and so on.
#
# Ex:
# if the last number "0" gets printed with reg_a = 0b010
# the next number "3" mus be outputed by reg_a = 0b010???
# 
# so every iteration we test all 3bit numbers and add them to a search queue
# since multiples values of A can solve the quine, but we need the lowest one.

until queue.empty?
  prev = queue.pop
  # test 1 8bit number at the time
  (0..7).each do |dif|
    reg_a = prev * 8 + dif # append 8bit number to currrent value
    comp_output = ChronospatialComputer.new(reg_a,0,0,original_instructions).output!
    target_output = orig_output[-1*comp_output.length..] # check tail of originial output
    queue << reg_a if comp_output.eql? target_output # if tails match, add to search queue
    found << reg_a if comp_output.eql? orig_output # found a number that solves the quine
  end
end

p found.min
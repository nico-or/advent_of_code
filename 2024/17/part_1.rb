# frozen_string_literal: true

require_relative 'chronospatial_computer'
FILENAME = ARGV[0]

input = File.read(FILENAME)

computer = ChronospatialComputer.from_string input
computer.calculate! until computer.halted?
puts computer.output

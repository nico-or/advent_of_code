# frozen_string_literal: true

START = 'S'
SPACE = '.'
SPLITTER = '^'

filename = ARGV[0] || 'sample.txt'

input = File.read(filename).lines(chomp: true)

rays = Set.new

rays << input.first.index(START)

sum = 0

input[1..].each do |line|
  next unless line.index(SPLITTER)

  n_rays = Set.new

  line.each_char.with_index do |char, idx|
    next unless rays.include?(idx)

    case char
    when SPACE
      n_rays << idx
    when SPLITTER
      sum += 1
      n_rays << (idx - 1)
      n_rays << (idx + 1)
    end
  end

  rays = n_rays
end

p sum

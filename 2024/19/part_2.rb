# frozen_string_literal: true

FILENAME = ARGV[0]

patterns, *designs = File.readlines(FILENAME, chomp: true)

patterns = patterns.split(', ').sort
designs = designs.reject(&:empty?)

def is_possible?(design, patterns, memo = {})
  return memo[design] if memo.key? design
  return 1 if design.empty?

  sum = patterns.sum do |pattern|
    next 0 unless design.start_with? pattern
    is_possible?(design.sub(pattern,''), patterns, memo)
  end
  memo[design] = sum
end

puts  designs.sum { |design| is_possible?(design,patterns) }
# frozen_string_literal: true

FILENAME = ARGV[0]

patterns, *designs = File.readlines(FILENAME, chomp: true)

patterns = patterns.split(', ').sort
designs = designs.reject(&:empty?)

def is_possible?(design, patterns, memo = {})
  return memo[design] if memo.key? design
  return true if patterns.include? design

  patterns.any? do |pattern|
    next unless design.start_with? pattern
    memo[design] = is_possible?(design.sub(pattern,''), patterns, memo)
  end
end

puts designs.count { |design| is_possible?(design,patterns) }
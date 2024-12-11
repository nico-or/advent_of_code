# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

# dictionary of rules
rules = input.lines(chomp: true)
             .filter { |line| line.include? '|' }

# array of update
updates = input.lines(chomp: true)
               .filter { |line| line.include? ',' }
               .map { |line| line.scan(/\d+/).map(&:to_i) }

# returns an array of every rule that would invalidate the input array
def breaking_rules(array)
  0.upto(array.length - 1).flat_map do |i|
    curr = array[i]
    array[i + 1..].map { |nxt| "#{nxt}|#{curr}" }
  end
end

valid_updates = updates.reject do |update|
  breaking_rules(update).any? { |rule| rules.include?(rule) }
end

foo = valid_updates.sum do |update|
  mid_idx = update.length / 2
  update[mid_idx]
end

puts "sum of midd numbers: #{foo}"

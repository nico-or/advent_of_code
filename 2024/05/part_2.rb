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

def valid_update?(rules, update)
  breaking_rules(update).none? { |rule| rules.include?(rule) }
end

bad_updates = updates.reject { |update| valid_update?(rules, update) }

def fix_update(rules, update)
  return update if valid_update?(rules, update)

  bad_rules = breaking_rules(update).filter { |rule| rules.include?(rule) }
  head, tail = bad_rules.first.split('|').map(&:to_i)

  h_idx = update.find_index(head)
  t_idx = update.find_index(tail)

  # swap
  update[h_idx], update[t_idx] = update[t_idx], update[h_idx]

  fix_update(rules, update)
end

fixed_updates = bad_updates.map { |update| fix_update(rules, update) }

puts "sum: #{fixed_updates.sum { |update| update[update.length / 2] }}"

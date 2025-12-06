# frozen_string_literal: true

filename = ARGV[0]

input = File.readlines(filename, chomp: true)

transposed = input.map(&:chars).transpose

sum = 0
queue = []

transposed.reverse_each do |*nums, op|
  num = nums.join.to_i

  next if num.zero?

  queue << num

  if %w[+ *].include?(op)
    sum += queue.reduce(&op.to_sym)
    queue = []
  end
end

puts sum

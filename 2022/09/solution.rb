require_relative "lib/rope"

instructions = File.read("input.txt")

puts "First part"
puts "----------"
head = Head.new

instructions.lines.each do |instruction|
  head.move(instruction)
end

visited_positions = head.knots.last.memory

puts "Unique visited positions count: #{visited_positions.uniq(&:to_s).count}"

puts "Second part"
puts "----------"

head = Head.new(0, 0, 9)

instructions.lines.each do |instruction|
  head.move(instruction)
end

visited_positions = head.knots.last.memory

puts "Unique visited positions count: #{visited_positions.uniq(&:to_s).count}"

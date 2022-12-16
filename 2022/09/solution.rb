require_relative "lib/rope"

head = Head.new

instructions = File.read("input.txt")
instructions.lines.each do |instruction|
  head.move(instruction)
end

puts "Unique visited positions count: #{head.tail.memory.uniq(&:to_s).count}"

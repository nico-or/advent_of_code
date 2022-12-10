require_relative "./lib/calorie_counter"

input = File.read("input.txt")

counter = CalorieCounter.new(input)

puts format("First part: %d", counter.max_calories)
puts format("Second part: %d", counter.max_calories(3))

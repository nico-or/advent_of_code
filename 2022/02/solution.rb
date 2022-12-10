require_relative "./lib/solution"

input = File.read("input.txt")
game = Game.new(input)

puts format("First part: %d", game.score)

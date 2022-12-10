require_relative "./lib/solution"

input = File.read("input.txt")
game = Game.new(input)

puts format("Game score: %d", game.score)

require_relative "lib/forest"

forest = Forest.from_file("./input.txt")
forest.check_visibiliy!

puts "total visible trees: #{forest.visible_trees.count}"

require_relative "lib/rucksack"

sacks = Rucksack.load_file("./input.txt")

puts sacks.map(&:errors)
          .flatten
          .map { Rucksack.get_priority _1 }
          .sum

require_relative "lib/monkey"

monkeys = Monkey.from_file("input.txt")

10_000.times { Monkey.round(monkeys) }

p Monkey.monkey_business(monkeys)

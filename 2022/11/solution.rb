require_relative "lib/monkey"

input = File.read("input.txt")

monkeys = input.split("\n\n").map { Monkey.new _1 }

20.times do |count|
  round(monkeys)
end

p monkey_businnes(monkeys)

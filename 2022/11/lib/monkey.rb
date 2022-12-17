require_relative "monkey/parser"
require_relative "monkey/monkey"

def round(monkeys)
  monkeys.each do |monkey|
    monkey.inspect_items!(monkeys)
  end
end

def monkey_businnes(monkeys)
  monkeys
    .map(&:inspected_items)
    .max(2)
    .reduce(1, :*)
end

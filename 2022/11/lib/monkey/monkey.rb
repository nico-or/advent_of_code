class Monkey
  include Parser

  def self.from_file(filename)
    File.read(filename)
      .split("\n\n")
      .map { Monkey.new _1 }
  end

  def self.round(monkeys)
    monkeys.each do |monkey|
      monkey.inspect_items!(monkeys)
    end
  end

  def self.monkey_business(monkeys)
    monkeys
      .map(&:inspected_items)
      .max(2)
      .reduce(1, :*)
  end

  attr_reader :number, :items, :inspected_items, :divisor

  def initialize(input)
    @number = find_integer(input.lines[0])
    @items = find_all_integers(input.lines[1])
    @operation = operation(input.lines[2])
    @divisor = find_integer(input.lines[3])
    @monkey_true = find_integer(input.lines[4])
    @monkey_false = find_integer(input.lines[5])
    @inspected_items = 0
  end

  def <<(item)
    @items << item
  end

  def inspect_items!(monkeys)
    lcm = monkeys.map(&:divisor).reduce(&:lcm)

    until items.empty?
      item = items.shift
      new_worry = @operation.call(item) % lcm
      monkey_target = divisible?(new_worry) ? @monkey_true : @monkey_false
      monkeys[monkey_target] << new_worry
      @inspected_items += 1
    end
  end

  private

  def divisible?(number)
    (number % @divisor).zero?
  end
end

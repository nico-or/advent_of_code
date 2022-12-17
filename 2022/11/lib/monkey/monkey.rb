class Monkey
  include Parser

  attr_reader :number, :items, :inspected_items

  def initialize(input)
    @number = find_integer(input.lines[0])
    @items = find_all_integers(input.lines[1])
    @operation = operation(input.lines[2])
    @test = test(input.lines[3])
    @monkey_true = find_integer(input.lines[4])
    @monkey_false = find_integer(input.lines[5])
    @inspected_items = 0
  end

  def <<(item)
    @items << item
  end

  def inspect_items!(monkeys)
    until items.empty?
      item = items.shift
      new_worry = @operation.call(item) / 3
      monkey_target = @test.call(new_worry) ? @monkey_true : @monkey_false
      monkeys[monkey_target] << new_worry
      @inspected_items += 1
    end
  end
end

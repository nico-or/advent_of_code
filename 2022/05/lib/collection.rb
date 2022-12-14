require "forwardable"

class Collection
  def self.from_file(filename = "./spec/fixtures/input.txt")
    parser = Parser.new(filename)
    parser.output

    collection = Collection.new(parser.stack_count)

    parser.output.each.with_index do |stack_items, index|
      stack_items.each { collection[index].push _1 }
    end

    collection
  end

  attr_reader :stacks

  extend Forwardable
  def_delegators :@stacks, :[], :push, :<<

  def initialize(size)
    @stacks = Array.new(size) { Stack.new }
  end

  def ==(other)
    stacks.zip(other.stacks).all? { |this, that| this == that }
  end

  def code
    @stacks
      .map { _1.top }
      .join
  end

  def move!(string)
    instruction = Instruction.new(string)
    crates = instruction.count.times.with_object([]) do |count, arr|
      arr << @stacks[instruction.from].pop
    end
    @stacks[instruction.to] += crates.reverse
  end
end

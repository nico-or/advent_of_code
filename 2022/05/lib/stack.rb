require "forwardable"

class Stack
  attr_reader :items

  extend Forwardable
  def_delegators :@items, :push, :pop, :<<

  def initialize(input = "")
    @items = input.chars
  end

  def top
    items.last
  end

  def ==(other)
    items == other.items
  end
end

module Rucksack
  class Rucksack
    attr_reader :first, :second, :items

    def initialize(input)
      n = input.length
      @items = input.chars
      @first = input.slice(0...n / 2)
      @second = input.slice(n / 2..)
    end

    def errors
      first.chars.intersection second.chars
    end
  end
end

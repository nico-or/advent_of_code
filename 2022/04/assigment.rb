class Assigment
  attr_reader :start, :end

  def initialize(input)
    @start, @end = input.split("-").map(&:to_i)
  end

  def include?(number)
    @start.upto(@end).include?(number)
  end

  def fully_contain?(assigment)
    include?(assigment.start) && include?(assigment.end)
  end

  def overlap?(other)
    self.entries.intersection(other.entries).any?
  end

  def entries
    Range.new(self.start, self.end).entries
  end
end

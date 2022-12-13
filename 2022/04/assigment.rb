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
end

class Instruction
  attr_reader :count, :from, :to

  REGEX = /move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/

  def initialize(string)
    match = REGEX.match string
    @count = match["count"].to_i
    @from = match["from"].to_i - 1
    @to = match["to"].to_i - 1
  end

  def ==(other)
    count == other.count &&
      from == other.from &&
      to == other.to
  end
end

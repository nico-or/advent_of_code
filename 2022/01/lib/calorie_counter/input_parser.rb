class InputParser
  def self.parse(input)
    input.split("\n\n")
      .map { _1.split("\n").map(&:to_i) }
  end
end

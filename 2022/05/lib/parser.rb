class Parser
  attr_reader :input

  def initialize(filename = "./spec/fixtures/input.txt")
    @input = File.read(filename)
  end

  def stack_count
    @stack_count ||= input.scan(/\s[0-9]\s{2}/)
                          .map(&:strip)
                          .map(&:to_i)
                          .last
  end

  def crate_items
    input
      .scan(/\[([A-Z])\]\s|\s(\s)\s{2}/)
      .flat_map(&:compact)
  end

  def output
    return @output if @output

    @output = Array.new(stack_count) { Array.new }

    crate_items.each.with_index do |item, index|
      output[index % stack_count].push item if item != " "
    end
    output.each(&:reverse!)
  end

  def instructions
    input.scan(/move .*/)
  end
end

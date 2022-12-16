class CPU
  def self.from_file(filename)
    cpu = CPU.new

    File.readlines(filename).each do |instruction|
      cpu.execute!(instruction)
    end

    cpu
  end

  attr_reader :history

  def initialize
    @history = []
    @pending = 0
  end

  def last
    history.last || Cycle.new(0, 1)
  end

  def noop!
    @history << last.next(@pending)
    @pending = 0
  end

  def addx!(value)
    noop!
    noop!
    @pending = value
  end

  def execute!(instruction)
    case instruction
    when /noop/
      noop!
    when /addx/
      value = instruction.scan(/-?\d+/).first.to_i
      addx!(value)
    end
  end

  def [](number)
    history[number - 1]
  end

  def signal_strength
    history
      .select { |cycle| ((cycle.number - 20) % 40).zero? }
      .sum(&:signal_strength)
  end
end

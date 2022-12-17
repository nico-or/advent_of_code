class CRT
  attr_reader :message

  ROWS = 6
  WIDTH = 40

  def initialize(history)
    @history = history
    @message = ""
    draw!
  end

  def draw!
    @history.each.with_index do |cycle, index|
      crt_column = (index % WIDTH) + 1
      cpu_column = cycle.value

      char = crt_column.between?(cpu_column, cpu_column + 2) ? "#" : "."
      @message << char

      @message << "\n" if crt_column.eql? WIDTH
    end
  end
end

class Shaft
  attr_reader :height, :rocks, :width, :falling_rock

  def initialize(width = 7, wind_input = "")
    @width = width
    @height = 0
    @rocks = []
    @wind = wind_input.chars.map(&:to_sym)
  end

  def new_rock!(shape_type = nil)
    if shape_type
      @falling_rock = Rock.new([height + 3, 2], shape_type)
    else
      @falling_rock = Rock.next([height + 3, 2])
    end

    while falling_rock.falling?
      falling_rock.move!(@wind.first, self)
      @wind.rotate!
    end

    @rocks << @falling_rock
    @falling_rock = nil
    @height = occupied_positions(20).max_by { |r, _| r }[0] + 1
  end

  def to_s
    arr = Array.new(height) { Array.new(width) { "." } }

    if falling_rock
      falling_rock.positions.each do |row, col|
        arr[row][col] = "@"
      end
    end

    occupied_positions.each do |row, col|
      arr[row][col] = "#"
    end

    arr.reverse.map do |row|
      "|#{row.join}|\n"
    end.join() << "+#{"-" * width}+"
  end

  def occupied_positions(count = nil)
    if count
      rocks.last(count).flat_map(&:positions)
    else
      rocks.flat_map(&:positions)
    end
  end
end

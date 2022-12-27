class Rock
  ROCKS = [
    [[0, 0], [0, 1], [0, 2], [0, 3]],
    [[0, 1], [1, 0], [1, 1], [1, 2], [2, 1]],
    [[0, 0], [0, 1], [0, 2], [1, 2], [2, 2]],
    [[0, 0], [1, 0], [2, 0], [3, 0]],
    [[0, 0], [0, 1], [1, 0], [1, 1]],
  ]
  @@last_rock = 0

  def self.next(pos = [0, 0])
    type = @@last_rock
    @@last_rock = (@@last_rock + 1) % ROCKS.length
    Rock.new(pos, type)
  end

  attr_reader :positions

  def initialize(start_position = [0, 0], type = 0)
    @positions = ROCKS[type].dup
    shift_positions!(start_position)

    @falling = true
  end

  def move!(direction, shaft)
    occupied_positions = shaft.occupied_positions(20)
    shaft_min_col = 0
    shaft_max_col = shaft.width - 1

    case direction
    when :< then move_left!(occupied_positions, shaft_min_col, shaft_max_col)
    when :> then move_right!(occupied_positions, shaft_min_col, shaft_max_col)
    end
    fall!(occupied_positions)
  end

  def falling?
    @falling
  end

  def move_left!(occupied_positions, shaft_min_col, shaft_max_col)
    old_positions = positions.dup
    shift_positions!([0, -1])

    if positions.any? do |pos|
      ilegal_position?(pos, occupied_positions, shaft_min_col, shaft_max_col)
    end
      @positions = old_positions
    end
  end

  def move_right!(occupied_positions, shaft_min_col, shaft_max_col)
    old_positions = positions.dup
    shift_positions!([0, 1])

    if positions.any? do |pos|
      ilegal_position?(pos, occupied_positions, shaft_min_col, shaft_max_col)
    end
      @positions = old_positions
    end
  end

  def fall!(occupied_positions)
    old_positions = positions.dup
    shift_positions!([-1, 0])
    if positions.any? do |pos|
      hit_floor?(pos, occupied_positions)
    end
      @positions = old_positions
      @falling = false
    end
  end

  def max_height
    positions.max_by { |row, _| row }[0]
  end

  private

  def ilegal_position?(position, occupied_positions, shaft_min_col, shaft_max_col)
    hit_wall?(position, shaft_min_col, shaft_max_col) ||
    hit_floor?(position, occupied_positions)
  end

  def hit_wall?(position, shaft_min_col, shaft_max_col)
    row, col = position
    col < shaft_min_col || col > shaft_max_col
  end

  def hit_floor?(position, occupied_positions)
    row, col = position
    row < 0 || occupied_positions.include?(position)
  end

  def shift_positions!(diff)
    drow, dcol = diff
    @positions.map! do |row, col|
      [row + drow, col + dcol]
    end
  end
end

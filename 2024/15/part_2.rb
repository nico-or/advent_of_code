# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)
map, moves = input.split("\n\n")

moves = moves.chars.filter { %w[^ v < >].include?(_1) }
DIRECTIONS = {
  '^' => Complex(-1, 0),
  'v' => Complex(1, 0),
  '<' => Complex(0, -1),
  '>' => Complex(0, 1)
}.freeze

grid = {}
map.lines(chomp: true).each_with_index do |row, row_idx|
  row.gsub(/[#.@O]/, { '#' => '##', '.' => '..', '@' => '@.', 'O' => '[]' })
     .chars.each_with_index do |char, col_idx|
    grid[Complex(row_idx, col_idx)] = char
  end
end

curr_pos = grid.key('@')

def move(grid, pos, dir)
  next_pos = pos + DIRECTIONS[dir]
  case grid[next_pos]
  when '#'
    return [:error, pos]
  when '['
    if ['^', 'v'].include?(dir)
      next_left = next_pos
      next_right = next_pos + Complex(0, 1)
      status1, = move(grid, next_left, dir)
      status2, = move(grid, next_right, dir)
      return [:error, pos] unless [status1, status2].all? { _1.eql? :ok }
    else
      status, = move(grid, next_pos, dir)
      return [:error, pos] unless status.eql? :ok
    end
  when ']'
    if ['^', 'v'].include?(dir)
      next_right = next_pos
      next_left = next_pos + Complex(0, -1)
      status1, = move(grid, next_left, dir)
      status2, = move(grid, next_right, dir)
      return [:error, pos] unless [status1, status2].all? { _1.eql? :ok }
    else
      status, = move(grid, next_pos, dir)
      return [:error, pos] unless status.eql? :ok
    end
  end
  grid[next_pos], grid[pos] = grid[pos], grid[next_pos]
  [:ok, next_pos]
end

def print_grid(grid)
  x_max = grid.keys.map(&:real).max
  y_max = grid.keys.map(&:imag).max

  (0..x_max).map do |x|
    (0..y_max).map do |y|
      grid[Complex(x, y)]
    end.join
  end.join("\n")
end

moves.each do |dir|
  old_grid = grid.to_a.to_h
  status, next_pos = move(grid, curr_pos, dir)
  if status == :ok
    curr_pos = next_pos
  else
    grid = old_grid
  end
end

p grid.select { |_, char| char.eql?('[') }
      .map { |pos, _| 100 * pos.real + pos.imag }
      .sum

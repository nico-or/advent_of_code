# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)
map, moves = input.split("\n\n")

moves = moves.chars.filter { %w[^ v < >].include?(_1) }
directions = {
  '^' => Complex(-1, 0),
  'v' => Complex(1, 0),
  '<' => Complex(0, -1),
  '>' => Complex(0, 1)
}

grid = {}
map.lines(chomp: true).each_with_index do |row, row_idx|
  row.chars.each_with_index do |char, col_idx|
    grid[Complex(row_idx, col_idx)] = char
  end
end

curr_pos = grid.key('@')

def move(grid, pos, dir)
  next_pos = pos + dir
  case grid[next_pos]
  when '.'
    grid[next_pos], grid[pos] = grid[pos], grid[next_pos]
    [:ok, next_pos]
  when 'O'
    status, = move(grid, next_pos, dir)
    return :error, pos unless status.eql? :ok

    grid[next_pos], grid[pos] = grid[pos], grid[next_pos]
    [:ok, next_pos]
  when '#'
    [:error, pos]
  else
    raise NotImplementedError, "Unhandled grid element: #{next_pos}: #{grid[next_pos]}"
  end
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
  delta = directions[dir]
  status, next_pos = move(grid, curr_pos, delta)
  curr_pos = next_pos if status == :ok
end

p grid.select { |_, char| char.eql?('O') }
      .map { |pos, _| 100 * pos.real + pos.imag }
      .sum

# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.readlines(FILENAME, chomp: true)

def string_to_hash(string)
  hash = {}
  string.lines(chomp: true).each_with_index do |row, row_idx|
    row.chars.each_with_index do |char, col_idx|
      hash[char] = [row_idx, col_idx]
    end
  end
  hash
end

def num_keystrokes(hash, a, b)
  xa, ya = hash[a]
  xb, yb = hash[b]
  dist_x = xb - xa
  dist_y = yb - ya

  out = ''

  if %w[1 4 7].include?(b) && %w[0 A].include?(a)
    out += '^' * -dist_x if dist_x.negative?
    out += '<' * -dist_y if dist_y.negative?
  else
    out += '<' * -dist_y if dist_y.negative?
    out += '^' * -dist_x if dist_x.negative?
  end
  out += 'v' * dist_x if dist_x.positive?
  out += '>' * dist_y if dist_y.positive?
  out.chars << 'A'
end

def dir_keystrokes(hash, a, b)
  xa, ya = hash[a]
  xb, yb = hash[b]
  dist_x = xb - xa
  dist_y = yb - ya

  out = ''
  out += '<' * -dist_y if dist_y.negative?
  out += '^' * -dist_x if dist_x.negative?
  out += 'v' * dist_x if dist_x.positive?
  out += '>' * dist_y if dist_y.positive?
  out.chars << 'A'
end

num_string = "789\n456\n123\n.0A\n"
dir_string = ".^A\n<v>\n"
num_map = string_to_hash(num_string)
dir_map = string_to_hash(dir_string)

out = input.map do |sequence|
  state = %w[A A A]
  robot_1 = sequence.chars.flat_map do |to|
    from = state[0]
    state[0] = to
    num_keystrokes(num_map, from, to)#.tap { puts "\t#{from},#{to} => #{_1.join}" }
  end

  robot_2 = robot_1.each.flat_map do |to|
    from = state[1]
    state[1] = to
    dir_keystrokes(dir_map, from, to)#.tap { puts "\t\t#{from},#{to} => #{_1.join}" }
  end

  robot_3 = robot_2.each.flat_map do |to|
    from = state[2]
    state[2] = to
    dir_keystrokes(dir_map, from, to)#.tap { puts "\t\t\t#{from},#{to} => #{_1.join}" }
  end

  length = robot_3.length
  numeric = sequence.scan(/\d+/).first.to_i
  [sequence, length, numeric, length * numeric ]
end

p out.map(&:last).sum

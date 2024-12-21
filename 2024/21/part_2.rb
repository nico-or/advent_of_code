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


num_string = "789\n456\n123\n.0A\n"
num_map = string_to_hash(num_string)

dir_map = {
  'A' => {
    'A' => %w[],
    '^' => %w[<],
    'v' => %w[< v],
    '<' => %w[v < <],
    '>' => %w[v]
  },
  '^' => {
    'A' => %w[>],
    '^' => %w[],
    'v' => %w[v],
    '<' => %w[v <],
    '>' => %w[v >]
  },
  'v' => {
    'A' => %w[^ >],
    '^' => %w[^],
    'v' => %w[],
    '<' => %w[<],
    '>' => %w[>]
  },
  '<' => {
    'A' => %w[> > ^],
    '^' => %w[> ^],
    'v' => %w[>],
    '<' => %w[],
    '>' => %w[> >]
  },
  '>' => {
    'A' => %w[^],
    '^' => %w[< ^],
    'v' => %w[<],
    '<' => %w[< <],
    '>' => %w[]
  }
}

def num_keystrokes(hash, a, b)
  xa, ya = hash[a]
  xb, yb = hash[b]
  dist_x = xb - xa
  dist_y = yb - ya

  out = []

  if %w[1 4 7].include?(b) && %w[0 A].include?(a)
    dist_x.abs.times { out << '^' }  if dist_x.negative?
    dist_y.abs.times { out << '<' }  if dist_y.negative?
  else
    dist_y.abs.times { out << '<' }  if dist_y.negative?
    dist_x.abs.times { out << '^' }  if dist_x.negative?
  end
  dist_x.times { out << 'v' }  if dist_x.positive?
  dist_y.times { out << '>' }  if dist_y.positive?
  out << 'A'
end

def dir_keystrokes(hash, a, b)
  hash[a][b].dup << 'A'
end

def dir_keystrokes_rec(hash, a, b, depth, memo)
  key = [a, b, depth]
  return memo[key] if memo.key?(key)

  keystrokes = dir_keystrokes(hash, a, b)
  return dir_keystrokes(hash, a, b).length if depth.zero?

  keystrokes = ['A'].concat keystrokes
  keystrokes.each_cons(2)
            .reduce(0) { |acc, (from, to)| acc + dir_keystrokes_rec(hash, from, to, depth - 1, memo) }
            .tap { memo[key] = _1 }
end

ROBOTS = ARGV[1].to_i
memo = {}

out = input.map do |sequence|
  sum = 0
  keystrokes = ['A'].concat(sequence.chars)
  keystrokes.each_cons(2).each do |from, to|
    keystrokes = num_keystrokes(num_map, from, to).then { ['A'].concat(_1) }
    sum += keystrokes.each_cons(2).reduce(0) do |acc, (from, to)|
      acc + dir_keystrokes_rec(dir_map, from, to, ROBOTS - 1, memo)
    end
  end

  len = sum
  num = sequence.scan(/\d+/).first.to_i
  mult = len * num
  [len, num, mult]
end

p out.map(&:last).sum

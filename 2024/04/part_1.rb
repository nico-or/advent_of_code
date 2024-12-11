# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

grid = {}
start_pos = []

input.lines(chomp: true).each.with_index do |row, i|
  row.chars.each.with_index do |char, j|
    start_pos << [i,j] if char.eql?('X')
    grid[[i, j]] = char
  end
end

p grid
p start_pos

def word_r(i,j)
  0.upto(3).map { |diff| [i, j + diff] }
end

def word_l(i,j)
  0.upto(3).map { |diff| [i, j - diff] }
end

def word_d(i,j)
  0.upto(3).map { |diff| [i + diff, j] }
end

def word_u(i,j)
  0.upto(3).map { |diff| [i - diff, j] }
end

def diag_rd(i,j)
  0.upto(3).map { |diff| [i + diff, j + diff] }
end

def diag_ru(i,j)
  0.upto(3).map { |diff| [i - diff, j + diff] }
end

def diag_ld(i,j)
  0.upto(3).map { |diff| [i + diff, j - diff] }
end

def diag_lu(i,j)
  0.upto(3).map { |diff| [i - diff, j - diff] }
end

def all_directions(i,j)
  [word_r(i,j),
  word_l(i,j),
  word_d(i,j),
  word_u(i,j),
  diag_rd(i,j),
  diag_ru(i,j),
  diag_ld(i,j),
  diag_lu(i,j)]
end

words = start_pos.flat_map do |pos|
  all_directions(*pos).map do |arr|
    arr.map { |ij| grid[ij] }.join
  end
end

TARGET="XMAS"
puts "count: #{words.count { |word| word.eql?(TARGET)} }"
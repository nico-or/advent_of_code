# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

grid = {}
start_pos = []

input.lines(chomp: true).each.with_index do |row, i|
  row.chars.each.with_index do |char, j|
    start_pos << [i,j] if char.eql?('A')
    grid[[i, j]] = char
  end
end

def diag_rd(i,j)
  -1.upto(1).map { |diff| [i + diff, j + diff] }
end

def diag_ru(i,j)
  -1.upto(1).map { |diff| [i - diff, j + diff] }
end

def diag_ld(i,j)
  -1.upto(1).map { |diff| [i + diff, j - diff] }
end

def diag_lu(i,j)
  -1.upto(1).map { |diff| [i - diff, j - diff] }
end

def all_directions(i,j)
  [
  diag_rd(i,j),
  diag_ru(i,j),
  diag_ld(i,j),
  diag_lu(i,j)]
end

words = start_pos.map do |pos|
  all_directions(*pos).count do |arr|
    arr.map { |ij| grid[ij] }.join.eql?('MAS')
  end
end
 p words.count { _1.eql? 2}
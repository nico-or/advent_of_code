# frozen_string_literal: true

require 'matrix'

class Piece
  def self.from_string(string)
    _index_str, p_str = string.split(":\n")

    p_lines = p_str.lines(chomp: true)

    n_row = p_lines.length
    n_col = p_lines.first.length

    m = Matrix.zero(n_row, n_col)

    p_lines.each_with_index do |row, row_index|
      row.chars.each_with_index do |col, col_index|
        next unless col == '#'

        m[row_index, col_index] = 1
      end
    end

    new(m)
  end

  def initialize(matrix)
    @matrix = matrix
  end

  def size
    [@matrix.row_size, @matrix.column_size]
  end

  def area
    @matrix.count { it == 1 }
  end

  def positions
    @matrix.each_with_index.filter_map do |e, row, col|
      [row, col] unless e.zero?
    end
  end

  def flip_v
    self.class.new(@matrix.transpose).rotate(-1)
  end

  def flip_h
    self.class.new(@matrix.transpose).rotate(1)
  end

  def rotate(count)
    self.class.new(@matrix.rotate_entries(count))
  end

  def rotations
    [
      m_rotations(@matrix),
      m_rotations(@matrix.transpose)
    ].flatten.uniq
  end

  def to_s
    @matrix.to_a.map do |row|
      row.map { |col| col.zero? ? '.' : '#' }.to_a.join
    end.join("\n")
  end

  private

  def m_rotations(matrix)
    [matrix, matrix.rotate_entries(1), matrix.rotate_entries(2), matrix.rotate_entries(3)]
  end
end

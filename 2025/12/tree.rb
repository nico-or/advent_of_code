# frozen_string_literal: true

class Tree
  def self.from_string(string)
    a_str, p_str = string.split(':')

    rows, cols = a_str.split('x').map(&:to_i)
    p_str.scan(/\d+/).map(&:to_i)

    new(rows, cols)
  end

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @area = Array.new(rows) { Array.new(cols, 0) }
  end

  def size
    [@rows, @cols]
  end

  def area
    @row * @cols
  end

  def valid?
    @area.flatten.any? { it > 1 }
  end

  def add(piece, pos_row, pos_col)
    pie_row, pie_col = piece.size

    max_row = (pos_row + pie_row - 1)
    max_col = (pos_col + pie_col - 1)

    raise ArgumentError if (max_row > @rows) || (max_col > @cols)

    offset_piece_positions(piece, pos_row, pos_col).each do |row_index, col_index|
      @area[row_index][col_index] += 1
    end
  end

  def to_s
    @area.map do |row|
      row.map { |col| col.zero? ? '.' : '#' }.join
    end.join("\n")
  end

  private

  # here or on piece?
  def offset_piece_positions(piece, row_off, col_off)
    piece.positions.map do |row, col|
      [row + row_off, col + col_off]
    end
  end
end

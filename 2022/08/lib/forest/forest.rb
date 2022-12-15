require "forwardable"

class Forest
  def self.from_file(filename)
    from_input(File.read filename)
  end

  def self.from_input(input)
    forest = Forest.new

    input.lines.each do |line|
      forest << line.chomp.chars.map do |height_string|
        Tree.new(height_string.to_i)
      end
    end

    forest
  end

  extend Forwardable

  def_delegators :@trees, :<<, :[]

  def initialize
    @trees = []
  end

  def trees
    @trees.flatten
  end

  def visible_trees
    check_visibiliy!
    trees.select(&:visible?)
  end

  def check_visibiliy!
    row_count = @trees.count
    column_count = @trees.transpose.count

    row_count.times do |i|
      column_count.times do |j|
        tree = @trees[i][j]

        surrounding_trees(i, j).each do |direction, trees|
          if trees.empty? || trees.map(&:height).max < tree.height
            tree.visible!
          end
        end
      end
    end
  end

  def surrounding_trees(i, j)
    {
      left: @trees[i][0...j],
      right: @trees[i][j + 1..],
      top: @trees.transpose[j][0...i],
      bottom: @trees.transpose[j][i + 1..],
    }
  end
end

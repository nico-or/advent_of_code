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
    trees.select(&:visible?)
  end

  def check_visibiliy!
    left_visibility!
    right_visibility!
    top_visibility!
    bottom_visibility!
  end

  def left_visibility!
    @trees.each do |row|
      max_height = -1
      row.each do |tree|
        if tree.height > max_height
          tree.visible!
          max_height = tree.height
        end
      end
    end
  end

  def right_visibility!
    @trees.each do |row|
      max_height = -1
      row.reverse_each do |tree|
        if tree.height > max_height
          tree.visible!
          max_height = tree.height
        end
      end
    end
  end

  def top_visibility!
    @trees.transpose.each do |column|
      max_height = -1
      column.each do |tree|
        if tree.height > max_height
          tree.visible!
          max_height = tree.height
        end
      end
    end
  end

  def bottom_visibility!
    @trees.transpose.each do |column|
      max_height = -1
      column.reverse_each do |tree|
        if tree.height > max_height
          tree.visible!
          max_height = tree.height
        end
      end
    end
  end
end

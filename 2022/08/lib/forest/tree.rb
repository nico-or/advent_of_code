class Tree
  attr_reader :height
  attr_accessor :score

  def initialize(height)
    @height = height
    @visible = false
    @score = 0
  end

  def visible!
    @visible = true
    self
  end

  def visible?
    @visible
  end

  def view_distance(row)
    return 0 if row.empty?

    index = row.find_index { |tree| tree.height >= self.height }

    index.nil? ? row.count : 1 + index
  end
end

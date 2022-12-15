class Tree
  attr_reader :height

  def initialize(height)
    @height = height
    @visible = false
  end

  def visible!
    @visible = true
    self
  end

  def visible?
    @visible
  end
end
